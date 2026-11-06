-- Packages
vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

-- Keep installed tools available before the first file is opened.
vim.env.MASON = vim.fn.stdpath('data') .. '/mason'
vim.env.PATH = vim.env.MASON .. '/bin:' .. vim.env.PATH

local group = vim.api.nvim_create_augroup('PluginLsp', { clear = true })
local loaded = false
local function setup()
  if loaded then
    return
  end
  loaded = true
  vim.api.nvim_clear_autocmds({ group = group })
  require('mason').setup({ PATH = 'skip' })
  require('mason-lspconfig').setup({
    automatic_enable = true,
    ensure_installed = {
      'lua_ls',
      'clangd',
      'rust_analyzer',
      'gopls',
      'pyright',
      'ruff',
      'zls',
      'ols',
      'bashls',
      'jsonls',
      'yamlls',
      'html',
      'cssls',
      'ts_ls',
      'marksman',
    },
  })
end

vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile', 'BufFilePost', 'FileType' }, {
  group = group,
  callback = function(event)
    local buffer = vim.bo[event.buf]
    if buffer.buftype == '' and (vim.api.nvim_buf_get_name(event.buf) ~= '' or buffer.filetype ~= '') then
      setup()
    end
  end,
})

vim.api.nvim_create_autocmd('CmdlineChanged', {
  group = group,
  pattern = ':',
  callback = function()
    local line = vim.fn.getcmdline()
    if line:match('^%s*lsp%f[%W]') or line:match('^%s*Lsp%u') then
      setup()
    end
  end,
})

-- Native commands replace these entrypoints on first use.
for name, nargs in pairs({
  Mason = 0,
  MasonInstall = '+',
  MasonUninstall = '+',
  MasonUninstallAll = 0,
  MasonUpdate = 0,
  MasonLog = 0,
  LspInstall = '*',
  LspUninstall = '+',
}) do
  vim.api.nvim_create_user_command(name, function(opts)
    setup()
    vim.api.nvim_cmd({ cmd = name, args = opts.fargs, mods = opts.smods }, {})
  end, {
    nargs = nargs,
    complete = nargs ~= 0 and function(_, line)
      setup()
      return vim.fn.getcompletion(line, 'cmdline')
    end or nil,
  })
end

-- Code actions: lazy picker
local code_action

-- Keymaps: code actions
vim.keymap.set({ 'n', 'x' }, '<leader>ca', function()
  if not code_action then
    vim.cmd.packadd('tiny-code-action.nvim')
    local actions = require('tiny-code-action')
    actions.setup({
      picker = 'buffer',
      backend = 'delta',
    })
    code_action = actions.code_action
  end
  code_action()
end, { desc = 'Code action' })

-- Keymaps: navigation
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end, { desc = 'Go to type definition' })
vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, { desc = 'Find references' })
vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { desc = 'Hover documentation' })
vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, { desc = 'Rename symbol' })

-- Keymaps: signature help
vim.keymap.set('i', '<C-f>', function() vim.lsp.buf.signature_help() end, {
  desc = 'Signature help',
})
