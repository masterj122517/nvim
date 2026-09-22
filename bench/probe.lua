local mode = vim.env.BENCH_MODE or 'startup'
local record_path = assert(vim.env.BENCH_RECORD, 'BENCH_RECORD is required')
local completion_count = tonumber(vim.env.BENCH_COMPLETION_COUNT) or 1
local snapshots = {}
local finished = false

local function append(record)
  local handle = assert(io.open(record_path, 'a'))
  handle:write(vim.json.encode(record), '\n')
  handle:close()
end

local function quit(code)
  if finished then
    return
  end
  finished = true
  vim.schedule(function()
    vim.cmd(code == 0 and 'qa!' or 'cquit ' .. tostring(code))
  end)
end

local function snapshot(name)
  local ok_stats, stats = pcall(function()
    return require('lazy').stats()
  end)
  local ok_config, config = pcall(require, 'lazy.core.config')
  local plugins = {}
  if ok_config then
    for plugin_name, plugin in pairs(config.plugins) do
      local loaded = plugin._ and plugin._.loaded or nil
      plugins[#plugins + 1] = {
        name = plugin_name,
        loaded = loaded ~= nil,
        time_ms = loaded and loaded.time and loaded.time / 1e6 or nil,
        reason = loaded,
      }
    end
    table.sort(plugins, function(left, right)
      return left.name < right.name
    end)
  end
  snapshots[name] = {
    at_ms = vim.uv.hrtime() / 1e6,
    stats = ok_stats and stats or nil,
    plugins = plugins,
  }
end

local function startup_probe()
  vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
      snapshot 'after_file'
    end,
  })
  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
      snapshot 'vim_enter'
      vim.defer_fn(function()
        if not snapshots.after_file then
          snapshot 'after_file'
        end
        if not snapshots.very_lazy then
          snapshot 'very_lazy'
        end
        append {
          kind = 'startup',
          fixture = vim.api.nvim_buf_get_name(0),
          snapshots = snapshots,
        }
        quit(0)
      end, 150)
    end,
  })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'VeryLazy',
    once = true,
    callback = function()
      snapshot 'very_lazy'
    end,
  })
end

local function completion_probe()
  local sample = 0
  local active = false
  local started_at = 0
  local timeout_generation = 0

  local function start_sample()
    sample = sample + 1
    timeout_generation = timeout_generation + 1
    local generation = timeout_generation
    pcall(function()
      require('blink.cmp').hide()
    end)
    vim.api.nvim_set_current_line 'local measured = benchmarkCompletionTarge'
    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], #vim.api.nvim_get_current_line() })
    active = true
    started_at = vim.uv.hrtime()
    if vim.api.nvim_get_mode().mode ~= 'i' then
      vim.cmd 'startinsert!'
    end
    vim.schedule(function()
      vim.api.nvim_input 't'
    end)
    vim.defer_fn(function()
      if active and timeout_generation == generation then
        active = false
        append {
          kind = 'completion',
          sample = sample,
          timeout = true,
          error = 'BlinkCmpMenuOpen timeout',
        }
        quit(2)
      end
    end, 2000)
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'BlinkCmpMenuOpen',
    callback = function()
      if not active then
        return
      end
      active = false
      local elapsed = (vim.uv.hrtime() - started_at) / 1e6
      local ok, items = pcall(function()
        return require('blink.cmp').get_items()
      end)
      local sources = {}
      if ok then
        for _, item in ipairs(items) do
          sources[item.source_id or item.source_name or 'unknown'] = true
        end
      end
      local completion_error = not ok and tostring(items) or nil
      append {
        kind = 'completion',
        sample = sample,
        elapsed_ms = elapsed,
        item_count = ok and #items or 0,
        sources = vim.tbl_keys(sources),
        timeout = false,
        error = completion_error,
      }
      if not ok or #items == 0 then
        quit(3)
      elseif sample >= completion_count then
        quit(0)
      else
        vim.defer_fn(start_sample, 20)
      end
    end,
  })

  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
      vim.defer_fn(start_sample, 20)
    end,
  })
end

local function ai_probe()
  local start = vim.uv.hrtime()
  local records = 0
  local function emit(event, fields)
    fields = fields or {}
    fields.kind = 'ai'
    fields.event = event
    fields.elapsed_ms = (vim.uv.hrtime() - start) / 1e6
    append(fields)
    records = records + 1
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'SidekickCliAttach',
    once = true,
    callback = function(event)
      emit('SidekickCliAttach', { data = event.data })
    end,
  })
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.name == 'copilot' then
        emit('copilot_attach', { client_id = client.id })
      end
    end,
  })
  vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
      vim.defer_fn(function()
        local ok, error_message = pcall(vim.cmd, 'Sidekick cli toggle opencode')
        if not ok then
          emit('SidekickCliAttach', { status = 'failed', error = tostring(error_message) })
        end
      end, 100)
      vim.defer_fn(function()
        if records == 0 then
          emit('provider_status', { status = 'timeout', error = 'no Sidekick or Copilot event' })
        end
        quit(0)
      end, 10000)
    end,
  })
end

if mode == 'startup' then
  startup_probe()
elseif mode == 'completion' then
  completion_probe()
elseif mode == 'ai' then
  ai_probe()
else
  error('unknown BENCH_MODE: ' .. mode)
end
