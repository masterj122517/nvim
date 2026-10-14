return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy=false',
            '--completion-style=detailed',
            '--header-insertion=iwyu',
            '--fallback-style=none',
            '--limit-results=200',
            '--limit-references=2000',
            '--pch-storage=memory',
            '--offset-encoding=utf-16',
          },
        },
      },
      filetype_options = {
        c = {
          tabstop = 2,
          softtabstop = 2,
          shiftwidth = 2,
          expandtab = true,
          formatoptions_remove = 'o',
        },
        cpp = {
          tabstop = 2,
          softtabstop = 2,
          shiftwidth = 2,
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
        c = { 'clang-format' },
        cpp = { 'clang-format' },
      },
    },
  },
}
