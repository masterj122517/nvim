-- Package
vim.pack.add({
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
})

-- Load before the first client's LspAttach event.
local group = vim.api.nvim_create_augroup('PluginInlineDiagnostic', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile', 'FileType' }, {
  group = group,
  callback = function()
    vim.api.nvim_clear_autocmds({ group = group })
    require("tiny-inline-diagnostic").setup({
      preset = "classic",
      options = {
        use_icons_from_diagnostic = true,
        multilines = {
          enabled = true,
        },
      },
    })
  end,
})

vim.g.diagnostics_active = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.lsp.diagnostic.clear(0)
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
  else
    vim.g.diagnostics_active = true
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
      }
    )
  end
end

vim.api.nvim_set_keymap('n', '<leader>td', ':call v:lua.toggle_diagnostics()<CR>', { noremap = true, silent = true })
