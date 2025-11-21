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
  })

  -- Enable the language server
  vim.lsp.enable 'luals'
end

return M
