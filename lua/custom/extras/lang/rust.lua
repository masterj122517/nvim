return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                features = 'all',
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = false,
              check = {
                command = 'check',
                features = 'all',
              },
              imports = {
                granularity = {
                  group = 'module',
                },
                prefix = 'self',
              },
              inlayHints = {
                chainingHints = { enable = true },
                closingBraceHints = { enable = true },
                typeHints = { enable = true },
                parameterHints = { enable = true },
              },
              diagnostics = {
                enable = true,
                experimental = false,
              },
            },
          },
        },
      },
      filetype_options = {
        rust = {
          tabstop = 4,
          softtabstop = 4,
          shiftwidth = 4,
          expandtab = true,
          formatoptions_remove = 'o',
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        rust = { 'rustfmt' },
      },
    },
  },
}
