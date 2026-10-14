return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('masterjVim_treesitter', { clear = true }),
      callback = function(event)
        pcall(vim.treesitter.start, event.buf)
      end,
    })
  end,
}
