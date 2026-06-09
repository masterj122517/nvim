vim.opt_local.tabstop = 2
vim.opt_local.formatoptions:remove 'o'
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>', { desc = 'Execute the current line' })
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { desc = 'Execute the current file' })

-- just like a snippets
vim.keymap.set('i', '++', ' = <Esc>^yt=f=lpa+ 1', {

  buffer = 0,
})

vim.keymap.set('i', '+=', '= <Esc>^yt=f=lpa+', {

  buffer = 0,
})
