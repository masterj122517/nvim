local M = {}

-- 检查 LSP 是否支持 documentHighlight
local function supports_document_highlight(client)
  return client.supports_method 'textDocument/documentHighlight'
end

function M.setup(client, bufnr)
  if not supports_document_highlight(client) then
    return
  end

  -- 创建 highlight 组
  local group = vim.api.nvim_create_augroup('lsp-highlight-' .. bufnr, { clear = true })

  -- 光标停留时高亮引用
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.buf.document_highlight,
  })

  -- 光标移动时清除引用
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.buf.clear_references,
  })

  -- LSP 断开时清理
  vim.api.nvim_create_autocmd('LspDetach', {
    group = vim.api.nvim_create_augroup('lsp-highlight-detach-' .. bufnr, { clear = true }),
    buffer = bufnr,
    callback = function(event)
      vim.lsp.buf.clear_references()
      vim.api.nvim_clear_autocmds { group = group, buffer = event.buf }
    end,
  })
end

return M
