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
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      -- 超过 1000 行跳过
      if vim.api.nvim_buf_line_count(bufnr) > 1000 then
        return
      end
      local disable_filetypes = { markdown = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 3000,
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
      javascript = { 'biome', 'prettierd', stop_after_first = true },
      javascriptreact = { 'biome', 'prettierd', stop_after_first = true },
      typescript = { 'biome', 'prettierd', stop_after_first = true },
      typescriptreact = { 'biome', 'prettierd', stop_after_first = true },
      vue = { 'biome', 'prettierd', stop_after_first = true },
      svelte = { 'biome', 'prettierd', stop_after_first = true },
      astro = { 'biome', 'prettierd', stop_after_first = true },
      html = { 'prettierd' },
      css = { 'biome', 'prettierd', stop_after_first = true },
      scss = { 'prettierd' },
      less = { 'prettierd' },
      json = { 'biome', 'prettierd', stop_after_first = true },
      jsonc = { 'biome', 'prettierd', stop_after_first = true },
      yaml = { 'prettierd' },
      graphql = { 'prettierd' },
    },
    formatters = {
      biome = {
        condition = function(_, ctx)
          return vim.fs.root(ctx.dirname, { 'biome.json', 'biome.jsonc' }) ~= nil
        end,
      },
    },
  },
}
