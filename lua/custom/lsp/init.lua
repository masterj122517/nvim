local M = {}

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

    if client and client.name == 'copilot' and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
      vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
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

    -- inlay hight
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.keymap.set('n', '<leader>th', function()
        local enabled = vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }
        vim.lsp.inlay_hint.enable(not enabled, { bufnr = event.buf })
      end, { buffer = event.buf, desc = 'Toggle Inlay Hints' })
    end

    -- diagnostic
    vim.diagnostic.config {
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        prefix = '●', -- 或者用 '■', '󰋔'
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
  return vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), completion, overrides or {})
end

-- Mason 自动安装
local servers = {
  'clangd',
  'gopls',
  -- 'pyright',
  'lua-language-server',
  'rust-analyzer',
  'jdtls',
  'copilot-language-server',
  -- 'haskell-language-server',
}

function M.setup()
  require('mason').setup()
  require('mason-tool-installer').setup {
    ensure_installed = vim.list_extend(vim.deepcopy(servers), {
      'stylua',
      'clang-format',
      'google-java-format',
    }),
    run_on_start = true,
    start_delay = 3000,
    debounce_hours = 24,
  }

  vim.lsp.config('copilot', {
    capabilities = M.capabilities(),
  })
  vim.lsp.enable 'copilot'

  require('custom.lsp.servers.lua_ls').setup()
  require('custom.lsp.servers.clangd').setup()
  require('custom.lsp.servers.gopls').setup()
  require('custom.lsp.servers.rust_analyzer').setup()
  require('custom.lsp.servers.pyright').setup()
  require('custom.lsp.servers.jdtls').setup()
end

return M
