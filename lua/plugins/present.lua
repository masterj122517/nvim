-- Package
vim.pack.add({
  'https://github.com/sotte/presenting.nvim',
})

-- Native commands replace these entrypoints on first use.
for _, command in ipairs({ 'Presenting', 'PresentingDevMode' }) do
  vim.api.nvim_create_user_command(command, function()
    require('presenting').setup({})
    vim.cmd(command)
  end, {})
end
