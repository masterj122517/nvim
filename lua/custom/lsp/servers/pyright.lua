local M = {}

function M.setup()
  -- Pyright Language Server
  vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', 'pyrightconfig.json', '.git' },
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'workspace',
          useLibraryCodeForTypes = true,
        },
      },
    },

    on_attach = require('custom.lsp').on_attach,
    capabilities = require('custom.lsp').capabilities,
  })

  -- Enable the server
  vim.lsp.enable 'pyright'
end

return M
