local M = {}

function M.setup()
  vim.lsp.config('clangd', {
    cmd = {
      'clangd',
      '--background-index', -- 后台生成索引，加速跳转、引用搜索
      '--clang-tidy', -- 启用 clang-tidy 检查
      '--completion-style=detailed', -- 更详细的补全
      '--header-insertion=iwyu', -- 自动添加 include
      '--fallback-style=none', -- 没有.clang-format就不自动format
      '--offset-encoding=utf-16', -- 防止与 LSP offset 不兼容（很重要）
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },
  })

  -- Enable the server
  vim.lsp.enable 'clangd'
end

return M
