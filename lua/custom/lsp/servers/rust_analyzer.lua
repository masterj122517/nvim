local M = {}

function M.setup()
  vim.lsp.config('rust_analyzer', {
    cmd = { 'rust-analyzer' },

    filetypes = { 'rust' },

    root_markers = { 'Cargo.toml', 'rust-project.json' },

    on_attach = require('custom.lsp').on_attach,
    capabilities = require('custom.lsp').capabilities,

    settings = {
      ['rust-analyzer'] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true, -- 让 RA 知道宏生成的代码在哪（使用宏的项目必须开）
          buildScripts = {
            enable = true,
          },
        },
        --checkOnSave.command = "clippy"
        checkOnSave = {
          command = 'clippy',
          allFeatures = true,
        },
        --让 import 自动组织得更整齐，不会乱。
        imports = {
          granularity = {
            group = 'module',
          },
          prefix = 'self',
        },
        --看类型/变量名更清晰。
        inlayHints = {
          chainingHints = true,
          closingBraceHints = true,
          typeHints = true,
          parameterHints = true,
        },

        diagnostics = {
          enabled = true,
          experimental = true,
        },
      },
    },
  })

  vim.lsp.enable 'rust_analyzer'
end

return M
