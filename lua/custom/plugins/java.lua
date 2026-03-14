return {
  {
    'eatgrass/maven.nvim',
    event = 'VeryLazy',
    ft = 'java',
    cmd = { 'Maven', 'MavenExec' },
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('maven').setup {
        executable = './mvnw',
      }
    end,
  },
  {
    'nvim-java/nvim-java',
    ft = 'java',
    config = function()
      require('java').setup()
      vim.lsp.enable 'jdtls'
    end,
  },
}
