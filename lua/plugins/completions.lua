-- Plugins
vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
  'https://github.com/rafamadriz/friendly-snippets',
})
-- Completion
require('blink.cmp').setup({
  cmdline = {
    keymap = {
      preset = 'cmdline',
      ['<C-Space>'] = false,
      ['<C-o>'] = { 'show', 'fallback' },
      ['<C-y>'] = { 'accept', 'fallback' },

      ['<Tab>'] = { 'show_and_insert', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'show_and_insert', 'select_prev', 'fallback' },

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
        auto_show = false, -- 按 Tab 才打开
      },
      ghost_text = {
        enabled = false,
      },
    },
  },
})
