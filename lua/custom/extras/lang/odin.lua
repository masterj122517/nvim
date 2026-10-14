return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ols = {},
      },
      filetype_options = {
        odin = {
          tabstop = 4,
          softtabstop = 4,
          shiftwidth = 4,
          expandtab = false,
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        odin = { 'odinfmt' },
      },
    },
  },
}
