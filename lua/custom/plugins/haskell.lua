return {
  'mrcjkb/haskell-tools.nvim',
  -- To avoid being surprised by breaking changes,
  -- I recommend you set a version range
  --version = '^9',
  -- This plugin implements proper lazy-loading (see :h lua-plugin-lazy).
  -- No need for lazy.nvim to lazy-load it.
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local ok_lsp, lsp = pcall(require, 'custom.lsp')
    local capabilities = ok_lsp and lsp.capabilities or vim.lsp.protocol.make_client_capabilities()

    vim.g.haskell_tools = {
      hls = {
        capabilities = capabilities,
        settings = {
          haskell = {
            formattingProvider = 'ormolu',
            checkProject = true,
          },
        },
      },
      tools = {
        codeLens = {
          autoRefresh = false,
        },
      },
    }
  end,
}
