local function package_context()
  local buffer_name = vim.api.nvim_buf_get_name(0)
  local start = buffer_name ~= '' and vim.fs.dirname(buffer_name) or vim.fn.getcwd()
  local package_file = vim.fs.find('package.json', { path = start, upward = true })[1]
  if not package_file then
    vim.notify('No package.json found', vim.log.levels.WARN)
    return
  end

  local ok, decoded = pcall(vim.json.decode, table.concat(vim.fn.readfile(package_file), '\n'))
  if not ok or type(decoded) ~= 'table' then
    vim.notify('Invalid package.json: ' .. package_file, vim.log.levels.ERROR)
    return
  end

  ---@cast decoded table<string, any>
  return package_file, decoded
end

local function package_manager(package_file, package)
  local declared = type(package.packageManager) == 'string' and package.packageManager:match '^([^@]+)'
  if declared and vim.tbl_contains({ 'bun', 'npm', 'pnpm', 'yarn' }, declared) then
    return declared
  end

  local lockfile = vim.fs.find({ 'bun.lock', 'bun.lockb', 'pnpm-lock.yaml', 'yarn.lock', 'package-lock.json' }, {
    path = vim.fs.dirname(package_file),
    upward = true,
  })[1]
  local managers = {
    ['bun.lock'] = 'bun',
    ['bun.lockb'] = 'bun',
    ['pnpm-lock.yaml'] = 'pnpm',
    ['yarn.lock'] = 'yarn',
    ['package-lock.json'] = 'npm',
  }
  return managers[lockfile and vim.fs.basename(lockfile)] or 'npm'
end

local function run_package_script()
  local package_file, package = package_context()
  if not package_file or not package then
    return
  end

  local scripts = {}
  for name, command in pairs(package.scripts or {}) do
    scripts[#scripts + 1] = { name = name, command = command }
  end
  table.sort(scripts, function(a, b)
    return a.name < b.name
  end)

  if #scripts == 0 then
    vim.notify('package.json has no scripts', vim.log.levels.WARN)
    return
  end

  vim.ui.select(scripts, {
    prompt = 'Run package script',
    format_item = function(item)
      return ('%-18s %s'):format(item.name, item.command)
    end,
  }, function(choice)
    if not choice then
      return
    end
    local manager = package_manager(package_file, package)
    require('snacks').terminal({ manager, 'run', choice.name }, {
      cwd = vim.fs.dirname(package_file),
      interactive = false,
      win = { position = 'bottom', height = 0.35 },
    })
  end)
end

return {
  {
    'yioneko/nvim-vtsls',
    lazy = true,
  },
  {
    'b0o/schemastore.nvim',
    lazy = true,
  },
  {
    'vuki656/package-info.nvim',
    ft = 'json',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      autostart = false,
      hide_up_to_date = true,
    },
    keys = {
      { '<leader>ns', '<cmd>PackageInfoShow<cr>', desc = 'Show dependency versions' },
      { '<leader>nt', '<cmd>PackageInfoToggle<cr>', desc = 'Toggle dependency versions' },
      { '<leader>nu', '<cmd>PackageInfoUpdate<cr>', desc = 'Update dependency' },
      { '<leader>ni', '<cmd>PackageInfoInstall<cr>', desc = 'Install dependency' },
      { '<leader>nd', '<cmd>PackageInfoDelete<cr>', desc = 'Delete dependency' },
      { '<leader>nc', '<cmd>PackageInfoChangeVersion<cr>', desc = 'Change dependency version' },
    },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = { use_default_keymaps = false, max_join_length = 120 },
    keys = {
      {
        '<leader>cj',
        function()
          require('treesj').toggle()
        end,
        desc = 'Split/join syntax node',
      },
    },
  },
  {
    'folke/snacks.nvim',
    keys = {
      { '<leader>nr', run_package_script, desc = 'Run package script' },
    },
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-jest',
    },
    opts = function()
      return {
        adapters = {
          require 'neotest-vitest' {
            filter_dir = function(name)
              return name ~= 'node_modules'
            end,
          },
          require 'neotest-jest' { jest_test_discovery = false },
        },
        discovery = { concurrent = 1 },
        quickfix = { open = false },
      }
    end,
    keys = {
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run nearest test',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run test file',
      },
      {
        '<leader>ta',
        function()
          require('neotest').run.run(vim.uv.cwd())
        end,
        desc = 'Run all tests',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug nearest test',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle test summary',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = 'Show test output',
      },
      {
        '<leader>tw',
        function()
          require('neotest').watch.toggle(vim.fn.expand '%')
        end,
        desc = 'Watch test file',
      },
    },
  },
}
