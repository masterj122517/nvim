local M = {}
-- Compilation state
local active
local last_command = 'make'

-- Quickfix display
local function quickfix_text(info)
  local lines = {}
  if info.end_idx - info.start_idx < 128 then
    -- Single-item reads avoid materializing the whole list for small redraws.
    for index = info.start_idx, info.end_idx do
      local item = vim.fn.getqflist({ id = info.id, idx = index, items = 0 }).items[1]
      lines[#lines + 1] = item.text
    end
  else
    -- Bulk reads avoid repeated linked-list traversal for large requests.
    local expression = "map(getqflist({'id': %d, 'items': 0}).items[%d:%d], 'v:val.text')"
    lines = vim.api.nvim_eval(expression:format(info.id, info.start_idx - 1, info.end_idx - 1))
  end
  for index, text in ipairs(lines) do
    text = text:gsub('\n', ' ')
    -- Empty strings fall back to Neovim's column separators.
    lines[index] = text == '' and ' ' or text
  end
  return lines
end

-- Diagnostic parsing
local function output_format()
  -- Only unescaped commas separate errorformat patterns.
  local formats = vim.fn.split(vim.o.errorformat, [[\\\@<!\%(\\\\\)*\zs,]])
  -- Preserve whole messages, including normally hidden log lines.
  for i, format in ipairs(formats) do
    local prefix, rest = format:match('^%%[-+]?([A-Z])(.*)$')
    formats[i] = prefix and ('%+' .. prefix .. rest) or ('%+G' .. format)
  end
  return '%DBuild directory: %f,' .. table.concat(formats, ',')
end

-- Asynchronous builds
local function build(command)
  local cwd = vim.fn.getcwd()
  local efm = output_format()
  if active then
    local previous = active
    active = nil
    vim.fn.jobstop(previous.job)
    vim.fn.setqflist({}, 'a', {
      id = previous.id,
      items = { { text = '[Compilation replaced]', valid = 0 } },
    })
  end

  vim.fn.setqflist({}, ' ', {
    nr = '$',
    title = command,
    lines = { 'Build directory: ' .. cwd },
    efm = efm,
    quickfixtextfunc = quickfix_text,
  })
  local run = {
    id = vim.fn.getqflist({ id = 0 }).id,
    pending = {},
    next_line = 1,
    tail = '',
    scheduled = false,
  }
  active = run
  vim.fn.setqflist({}, 'a', {
    id = run.id,
    items = { { text = '$ ' .. command, valid = 0 } },
  })

  local function flush()
    if active ~= run then
      return
    end
    run.scheduled = false
    local view = vim.fn.getqflist({ id = 0, nr = 0, size = 0, winid = 0 })
    local follow = view.id == run.id and view.winid ~= 0
        and vim.api.nvim_win_get_cursor(view.winid)[1] == view.size

    if run.next_line <= #run.pending then
      local previous = view.id == run.id and view.winid ~= 0 and view.size > 0
          and vim.fn.getqflist({ id = run.id, idx = view.size, items = 0 }).items[1]
      -- Bound each update so large logs do not block editing.
      local last = math.min(run.next_line + 999, #run.pending)
      local lines = vim.list_slice(run.pending, run.next_line, last)
      run.next_line = last + 1
      if run.next_line > #run.pending then
        run.pending = {}
        run.next_line = 1
      end
      if vim.fn.setqflist({}, 'a', { id = run.id, lines = lines, efm = efm }) == -1 then
        active = nil
        if run.job then
          vim.fn.jobstop(run.job)
        end
        return
      end
      if previous then
        local updated = vim.fn.getqflist({ id = run.id, idx = view.size, items = 0 }).items[1]
        if not vim.deep_equal(previous, updated) then
          -- Repaint a continued diagnostic without resetting its parser.
          local saved = vim.api.nvim_win_call(view.winid, vim.fn.winsaveview)
          vim.cmd('silent ' .. view.nr .. 'chistory')
          vim.api.nvim_win_call(view.winid, function() vim.fn.winrestview(saved) end)
        end
      end
    end
    if run.next_line <= #run.pending then
      run.scheduled = true
      vim.defer_fn(flush, 20)
    elseif run.status then
      vim.fn.setqflist({}, 'a', {
        id = run.id,
        items = { { text = run.status, valid = 0 } },
      })
      active = nil
    end
    if follow then
      local size = vim.fn.getqflist({ id = run.id, size = 0 }).size
      vim.api.nvim_win_set_cursor(view.winid, { size, 0 })
    end
  end

  function run.finish(status)
    if active ~= run then
      return
    end
    if run.tail ~= '' then
      run.pending[#run.pending + 1] = run.tail:gsub('\r$', '')
      run.tail = ''
    end
    run.status = status
    if not run.scheduled then
      flush()
    end
  end

  local function receive(_, data)
    if active ~= run then
      return
    end
    data[1] = run.tail .. data[1]
    for i = 1, #data - 1 do
      run.pending[#run.pending + 1] = data[i]:gsub('\r$', '')
    end
    run.tail = data[#data]
    if #run.pending > 0 and not run.scheduled then
      run.scheduled = true
      vim.defer_fn(flush, 20)
    end
  end

  local source = vim.api.nvim_get_current_win()
  vim.cmd('botright copen')
  local win = vim.fn.getqflist({ winid = 0 }).winid
  vim.api.nvim_win_set_cursor(win, { 2, 0 })
  vim.api.nvim_set_current_win(source)

  -- Merge streams before capture; jobstop terminates the process group.
  local argv = { 'sh', '-c', 'exec "$@" 2>&1', 'build', vim.o.shell }
  vim.list_extend(argv, vim.split(vim.o.shellcmdflag, '%s+', { trimempty = true }))
  argv[#argv + 1] = command
  local ok, job = pcall(vim.fn.jobstart, argv, {
    cwd = cwd,
    stdin = 'null',
    on_stdout = receive,
    on_exit = function(_, code)
      run.finish('[Process exited ' .. code .. ']')
    end,
  })
  if not ok or job <= 0 then
    run.pending[#run.pending + 1] = tostring(job)
    run.finish('[Process not started]')
    return
  end
  run.job = job
  return job
end

-- Odin diagnostics
local function odin_errorformat(buf)
  if vim.bo[buf].errorformat == '' then
    vim.bo[buf].errorformat = '%f(%l:%c) %t%*[^:]: %m,%f(%l:%c) %m'
  end
end
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('CustomCompile', { clear = true }),
  pattern = 'odin',
  callback = function(event)
    odin_errorformat(event.buf)
  end,
})
-- Set the fallback before Odin ftplugins load.
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufAdd' }, {
  group = 'CustomCompile',
  pattern = '*.odin',
  callback = function(event)
    odin_errorformat(event.buf)
  end,
})
for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  if vim.bo[buf].filetype == 'odin' then
    odin_errorformat(buf)
  end
end

-- Language commands
local function compileRun()
  local ft = vim.bo.filetype
  local file = vim.api.nvim_buf_get_name(0)
  if file == '' then
    return
  end
  vim.cmd('silent update')

  if ft == 'odin' then
    build('odin run .')
  elseif ft == 'c' then
    build('gcc ' .. vim.fn.shellescape(file) .. ' -o '
      .. vim.fn.shellescape(vim.fn.fnamemodify(file, ':r')))
  elseif ft == 'zig' then
    build('zig build run')
  elseif ft == 'python' then
    build('python3 ' .. vim.fn.shellescape(file))
  end
end

-- Command prompt
local function compile_manual()
  vim.cmd('redraw')
  local ok, command = pcall(vim.fn.input, {
    prompt = 'Compile: ',
    default = last_command,
    completion = 'shellcmdline', -- Command first, then file/directory arguments.
    cancelreturn = '',
  })
  if not ok or command == '' then
    return
  end
  last_command = command
  build(command)
end

-- Error navigation
local function jump_error(direction)
  for _ = 1, vim.v.count1 do
    repeat
      vim.cmd(direction == 1 and 'cnext' or 'cprev')
      local index = vim.fn.getqflist({ idx = 0 }).idx
      local entry = vim.fn.getqflist({ idx = index, items = 0 }).items[1]
    until entry.bufnr ~= 0
  end
end

-- Compilation keymaps
vim.keymap.set('n', '<leader>m', compile_manual, { desc = 'Compile command' })
-- custom is loaded before plugins; reclaim this key after their setup runs.
vim.schedule(function()
  vim.keymap.set('n', '<leader>m', compile_manual, { desc = 'Compile command' })
end)
vim.keymap.set('n', 'com', compileRun, { desc = 'Compile current file' })
vim.keymap.set('n', ']q', function() jump_error(1) end, { desc = 'Next compilation error' })
vim.keymap.set('n', '[q', function() jump_error(-1) end, { desc = 'Previous compilation error' })

-- Exports
M.build = build
M.run = compileRun
return M
