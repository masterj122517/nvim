-- Plugins
vim.pack.add({
  'https://github.com/folke/which-key.nvim',
})

-- Which-key
require('which-key').setup({
  delay = 200,

  icons = {
    mappings = vim.g.have_nerd_font,
    keys = vim.g.have_nerd_font and {} or {
      Up = '<Up> ',
      Down = '<Down> ',
      Left = '<Left> ',
      Right = '<Right> ',
      C = '<C-…> ',
      M = '<M-…> ',
      D = '<D-…> ',
      S = '<S-…> ',
      CR = '<CR> ',
      Esc = '<Esc> ',
      BS = '<BS> ',
      Space = '<Space> ',
      Tab = '<Tab> ',
    },
  },

  spec = {
    { '<leader>c', group = 'Code' },
    { '<leader>d', group = 'Debug' },
    { '<leader>s', group = 'Search' },
    { '<leader>t', group = 'Test / Toggle' },
  },
})
