vim.pack.add({
  'https://github.com/nvim-mini/mini.nvim',
  'https://github.com/iamcco/markdown-preview.nvim',
})
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('masterjVim_markdown', { clear = true }),
  pattern = 'markdown',
  once = true,
  callback = function()
    vim.cmd.packadd('render-markdown.nvim')
  end,
})

vim.api.nvim_create_user_command('RenderMarkdown', function(opts)
  vim.cmd.packadd('render-markdown.nvim')
  vim.cmd('RenderMarkdown ' .. opts.args)
end, {
  nargs = '*',
  complete = function(_, cmdline, cursorpos)
    vim.cmd.packadd('render-markdown.nvim')
    return vim.fn.getcompletion(cmdline:sub(1, cursorpos), 'cmdline')
  end,
})

vim.api.nvim_create_user_command('MarkdownPreviewInstall', function()
  vim.fn['mkdp#util#install']()
end, {})
