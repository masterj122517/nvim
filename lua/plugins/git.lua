-- Packages
vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = 'https://github.com/esmuellert/codediff.nvim' },
})

-- Git signs
require("gitsigns").setup()

-- Diff
vim.keymap.set('n', '<leader>gd', '<cmd>CodeDiff<CR>', { desc = 'CodeDiff' })
