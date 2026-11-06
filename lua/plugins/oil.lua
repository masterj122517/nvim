-- Packages
vim.pack.add({
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/refractalize/oil-git-status.nvim' },
})

-- File browsing
require('oil').setup({
  win_options = {
    signcolumn = 'yes:2',
  },
  view_options = {
    show_hidden = false,
  },
  watch_for_changes = true,
  use_default_keymaps = true,
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
  },
})

-- Git status
require('oil-git-status').setup({
  show_ignored = false,
})

-- Browsing keymap
vim.keymap.set('n', '-', '<cmd>Oil<CR>', { silent = true })
