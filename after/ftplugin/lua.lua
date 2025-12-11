vim.opt.tabstop = 2
vim.opt_local.formatoptions:remove 'o'
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>', { desc = 'Execute the current line' })
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Execute the current file' })
