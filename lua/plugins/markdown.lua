-- vim.pack.add({
--   "https://github.com/OXY2DEV/markview.nvim",
-- })

vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-mini/mini.nvim', -- if you use the mini.nvim suite
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/iamcco/markdown-preview.nvim',
})
require('render-markdown').setup({}) -- only mandatory if you want to set custom options

vim.api.nvim_create_user_command('MarkdownPreviewInstall', function()
  vim.fn['mkdp#util#install']()
end, {})
