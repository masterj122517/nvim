return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'mason-org/mason.nvim' },
    opts = {
      servers = { copilot = {} },
      filetype_options = {},
    },
    config = function(_, opts)
      require('custom.lsp').setup(opts)
    end,
  },
  {
    'mason-org/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUninstall', 'MasonUpdate', 'MasonLog' },
    opts = {},
  },
}
