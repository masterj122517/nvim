local util = require 'lspconfig.util'

local M = {}

function M.setup()
  vim.lsp.config('gopls', {
    cmd = { 'gopls' },

    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },

    root_markers = { 'go.work', 'go.mod', '.git' },

    settings = {
      gopls = {
        completeUnimported = true, -- 写代码时补全包名即自动加 import
        usePlaceholders = true, -- 自动补全函数参数
        staticcheck = true, -- 开启强力静态分析，比默认的强很多。
        --检查未使用的函数参数。
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        --显示类型、变量名提示
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          parameterNames = true,
          constantValues = true,
          rangeVariableTypes = true,
        },
      },
    },
  })

  vim.lsp.enable 'gopls'
end

return M
