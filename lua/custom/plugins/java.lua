return {
  {
    'eatgrass/maven.nvim',
    event = 'VeryLazy',
    cmd = { 'Maven', 'MavenExec' },
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require('maven').setup {
        executable = './mvnw',
      }
    end,
  },
}
