-- Indentation
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2

-- Lua execution
vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>', { silent = true, buffer = 0, desc = 'Execute the current line' })
vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>',
  { silent = true, buffer = 0, desc = 'Execute the current file' })

-- Insert snippets
vim.keymap.set('i', '++', ' = <Esc>^yt=f=lpa+ 1', {

  silent = true,
  buffer = 0,
})

vim.keymap.set('i', '+=', '= <Esc>^yt=f=lpa+', {
  silent = true,
  buffer = 0,
})
