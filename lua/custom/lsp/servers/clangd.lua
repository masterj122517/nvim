local M = {}

function M.setup()
  vim.lsp.config('clangd', {
    cmd = {
      'clangd',
      '--background-index', -- 后台生成索引，加速跳转、引用搜索
      '--clang-tidy=false', -- 减少后台诊断开销
      '--completion-style=detailed', -- 更详细的补全
      '--header-insertion=iwyu', -- 自动添加 include
      '--fallback-style=none', -- 没有.clang-format就不自动format
      '--limit-results=200', -- 限制结果数量，减少卡顿
      '--limit-references=2000',
      '--pch-storage=memory', -- 提升索引速度（更吃内存）
      '--offset-encoding=utf-16', -- 防止与 LSP offset 不兼容（很重要）
    },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
    root_markers = { '.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', 'compile_flags.txt', 'configure.ac', '.git' },

    on_attach = require('custom.lsp').on_attach,
    capabilities = require('custom.lsp').capabilities,
  })

  -- Enable the server
  vim.lsp.enable 'clangd'
end

return M
