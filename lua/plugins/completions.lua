-- Plugins
vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
  'https://github.com/rafamadriz/friendly-snippets',
})
-- Completion
require('blink.cmp').setup({
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    },
    menu = {
      auto_show = true,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = false,
    },
  },

  -- Keymaps
  keymap = {
    --  u can do default enter super-tab none
    -- we just go for enter
    preset = 'enter',
    ['<C-Space>'] = false,
    ['<C-o>'] = { 'show', 'fallback' },
    ['<C-y>'] = { 'accept', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
  },

  -- Completion sources
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  -- Command-line completion
  cmdline = {
    keymap = {
      preset = 'cmdline',
      ['<C-Space>'] = false,
      ['<C-o>'] = { 'show', 'fallback' },
      ['<C-y>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<Left>'] = false,
      ['<Right>'] = false,
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      menu = {
        auto_show = function()
          return vim.fn.getcmdtype() == ':'
        end,
      },
      ghost_text = {
        enabled = false,
      },
    },
  },
  -- Signature help
  signature = {
    enabled = true,
  },
})
