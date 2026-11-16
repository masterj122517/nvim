-- Packages
vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = 'https://github.com/esmuellert/codediff.nvim' },
  { src = 'https://github.com/tpope/vim-fugitive.git' },
})

-- Git signs
require("gitsigns").setup()

-- Diff
vim.keymap.set('n', '<leader>gcd', '<cmd>CodeDiff<CR>', { desc = 'CodeDiff' })
vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gb", "<cmd>rightbelow Git blame<cr>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Git diff split" })
vim.keymap.set("n", "<leader>gl", "<cmd>Git log --oneline<cr>", { desc = "Git log" })
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
