return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              staticcheck = false,
              analyses = {
                unusedparams = true,
                shadow = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                parameterNames = true,
                constantValues = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
      },
      filetype_options = {
        go = {
          tabstop = 2,
          softtabstop = 2,
          shiftwidth = 2,
          expandtab = true,
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        go = { 'goimports' },
      },
    },
  },
}
