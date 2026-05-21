local M = {}

-- Set up LspAttach autocmd for per-buffer configuration
local autocomplete_configured = false
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf

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

-- capabilities
M.capabilities = vim.tbl_deep_extend('force',
  vim.lsp.protocol.make_client_capabilities(),
  require('blink.cmp').get_lsp_capabilities()
)

-- Mason 自动安装
local servers = {
  'clangd',
  'gopls',
  'pyright',
  'lua-language-server',
  'rust-analyzer',
  'jdtls',
  'haskell-language-server',
}

function M.setup()
  require('mason').setup()
  require('mason-tool-installer').setup {
    ensure_installed = vim.list_extend(servers, {
      'stylua',
      'clang-format',
      'google-java-format',
    }),
  }

  require('custom.lsp.servers.lua_ls').setup()
  require('custom.lsp.servers.clangd').setup()
  require('custom.lsp.servers.gopls').setup()
  require('custom.lsp.servers.rust_analyzer').setup()
  require('custom.lsp.servers.pyright').setup()
  require('custom.lsp.servers.jdtls').setup()
end

return M
