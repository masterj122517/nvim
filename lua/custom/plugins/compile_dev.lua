return {
  dir = '~/programming/cm.nvim',
  config = function()
    require 'cm'
    vim.g.compile_mode = {
      default_command = 'make', -- 默认编译命令
      error_patterns = { -- 错误格式模式
        gcc = '([^:]+):(%d+):(%d+): (.*)',
        clang = '([^:]+):(%d+):(%d+): (.*)',
        make = '([^:]+):(%d+): (%w+): (.*)',
      },
      auto_open = true, -- 自动打开编译窗口
      auto_close = false, -- 编译完成后自动关闭窗口
    }
  end,
}
