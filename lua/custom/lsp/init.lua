local M = {}

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    -- 关闭 LSP 语义高亮，使用 Tree-sitter 配色
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end

    -- keymaps
    local ok_m, err_m = pcall(require('custom.lsp.keymaps').setup, bufnr)
    if not ok_m then
      vim.notify('Failed to set up keymaps: ' .. tostring(err_m), vim.log.levels.WARN)
    end

    -- highlight
    local ok_h, err_h = pcall(require('custom.lsp.highlight').setup, client, bufnr)
    if not ok_h then
      vim.notify('Failed to set up highlight: ' .. tostring(err_h), vim.log.levels.WARN)
    end

    -- inlay hints
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.keymap.set('n', '<leader>th', function()
        local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
      end, { buffer = bufnr, desc = 'Toggle Inlay Hints' })
    end

    -- diagnostic
    vim.diagnostic.config {
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        prefix = '●',
      },
      severity_sort = true,
    }
  end,
})

---@param overrides? table
---@return table
function M.capabilities(overrides)
  local completion = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
          commitCharactersSupport = false,
          documentationFormat = { 'markdown', 'plaintext' },
          deprecatedSupport = true,
          preselectSupport = false,
          tagSupport = { valueSet = { 1 } },
          insertReplaceSupport = true,
          resolveSupport = {
            properties = {
              'documentation',
              'detail',
              'additionalTextEdits',
              'command',
              'data',
            },
          },
          insertTextModeSupport = { valueSet = { 1 } },
          labelDetailsSupport = true,
        },
        completionList = {
          itemDefaults = {
            'commitCharacters',
            'editRange',
            'insertTextFormat',
            'insertTextMode',
            'data',
          },
        },
      },
    },
  }

  return vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    completion,
    overrides or {}
  )
end

local function apply_filetype_options(bufnr, options)
  local defaults = options[vim.bo[bufnr].filetype]
  if not defaults then
    return
  end

  for name, value in pairs(defaults) do
    if name == 'formatoptions_remove' then
      vim.bo[bufnr].formatoptions = vim.bo[bufnr].formatoptions:gsub('[' .. value .. ']', '')
    else
      vim.bo[bufnr][name] = value
    end
  end
end

---@param opts table
function M.setup(opts)
  local filetype_options = opts.filetype_options or {}

  vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('custom_language_options', { clear = true }),
    callback = function(event)
      apply_filetype_options(event.buf, filetype_options)
    end,
  })

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      apply_filetype_options(bufnr, filetype_options)
    end
  end

  for name, config in pairs(opts.servers or {}) do
    if config ~= false then
      vim.lsp.config(name, config)

      local resolved = vim.lsp.config[name]
      vim.lsp.config(name, {
        capabilities = M.capabilities(resolved.capabilities),
      })

      local cmd = resolved.cmd
      -- Mason 仅将手动安装的可执行文件加入 PATH，不在这里安装。
      if type(cmd) == 'function' or (type(cmd) == 'table' and vim.fn.executable(cmd[1]) == 1) then
        vim.lsp.enable(name)
      end
    end
  end
end

return M
