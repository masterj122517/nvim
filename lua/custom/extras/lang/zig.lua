return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        zls = {},
      },
      filetype_options = {
        zig = {
          tabstop = 4,
          softtabstop = 4,
          shiftwidth = 4,
          expandtab = true,
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        zig = { 'zigfmt' },
      },
    },
  },
}
