-- Plugins
vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
})

-- Mason
require('mason').setup()

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

-- Initialize the picker once, on its first invocation; server attachment stays eager.
local code_action

-- LSP keymaps
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

vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Find references' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })

-- Signature help
vim.keymap.set('i', '<C-f>', vim.lsp.buf.signature_help, {
  desc = 'Signature help',
})
