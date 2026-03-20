return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[C]ode [F]ormat',
    },
    {
      '<leader>uf', -- 您要求的快捷键 [U]nset [F]ormat
      function()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
          print 'Autoformat re-enabled'
        else
          vim.g.disable_autoformat = true
          print 'Autoformat disabled'
        end
      end,
      mode = 'n',
      desc = 'Toggle autoformat on save',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- 增加这一行判断：如果全局禁用了，则直接返回
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      local disable_filetypes = { markdown = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      go = { 'goimports' },
      rust = { 'rustfmt' },
      python = { 'black' },
    },
  },
}
