local M = {}

function M.setup()
  -- Define configuration for lua-language-server
  vim.lsp.config('luals', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = {
            'vim',
            'require',
          },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
        completion = {
          callSnippet = 'Replace',
        },
      },
    },

    on_attach = require('custom.lsp').on_attach,
    capabilities = require('custom.lsp').capabilities,
  })

  -- Enable the language server
  vim.lsp.enable 'luals'
end

return M
