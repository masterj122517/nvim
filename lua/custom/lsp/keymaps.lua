local M = {}

-- Global LSP keymaps (already exist in Neovim 0.11)
function M.setup_global()
  -- These are automatically set up by Neovim 0.11
  -- We'll add any additional global LSP keymaps here if needed
end

-- Buffer-specific LSP keymaps (set on LspAttach)
function M.setup(bufnr)
  bufnr = bufnr or 0 -- Default to current buffer if not provided
  -- local opts = { buffer = bufnr, noremap = true, silent = true }

  -- use snacks instead
  vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, { buffer = bufnr, noremap = true, silent = true, desc = 'signature_help' })

  -- Workspace management
  vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = bufnr, noremap = true, silent = true, desc = 'Buf Rename' })

  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, noremap = true, silent = true, desc = 'Code Actions' })
end

return M
