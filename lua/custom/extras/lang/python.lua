return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ruff = {
          cmd = { 'ruff', 'server' },
          root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml', '.git' },
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'ruff_format' },
      },
    },
  },
}
