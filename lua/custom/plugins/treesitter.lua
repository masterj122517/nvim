return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('masterjVim_treesitter', { clear = true }),
      callback = function(event)
        if vim.b[event.buf].ts_highlight then
          return
        end
        local parser = vim.treesitter.get_parser(event.buf)
        -- Leave syntaxset as the fallback when highlighting is unavailable.
        if parser and vim.treesitter.query.get(parser:lang(), 'highlights') then
          pcall(vim.treesitter.start, event.buf)
        end
      end,
    })
  end,
}
