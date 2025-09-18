return {
  {
    'airblade/vim-rooter',
    init = function()
      vim.g.rooter_patterns = {
        '__vim_project_root', -- 手动标记
        'pom.xml', -- Maven 项目
        'build.gradle', -- Gradle 项目
        'settings.gradle', -- Gradle 多模块
        'src/', -- 没有构建工具时用 src 目录当根
        '.git/', -- Git 仓库
      }
      vim.g.rooter_silent_chdir = true
      -- set an autocmd
      vim.api.nvim_create_autocmd('VimEnter', {
        pattern = '*',
        callback = function()
          -- source .vim.lua at project root
          vim.cmd [[silent! source .vim.lua]]
        end,
      })
    end,
  },
}
