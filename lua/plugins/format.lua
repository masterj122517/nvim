-- Plugin
vim.pack.add({
  'https://github.com/stevearc/conform.nvim',
})

-- Formatters
require('conform').setup({
  notify_on_error = false,

  formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'ruff_format' },
    c = { 'clang_format' },
    cpp = { 'clang_format' },
    rust = { 'rustfmt' },
    go = { 'gofmt' },
    zig = { 'zigfmt' },
  },

  formatters = {
    biome = {
      condition = function(_, ctx)
        return vim.fs.root(ctx.dirname, { 'biome.json', 'biome.jsonc' }) ~= nil
      end,
    },
  },

  -- Format on save
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    if vim.api.nvim_buf_line_count(bufnr) > 1000 then
      return
    end

    if vim.bo[bufnr].filetype == 'markdown' then
      return
    end

    return {
      timeout_ms = 3000,
      lsp_format = 'fallback',
    }
  end,
})

-- Format buffer
vim.keymap.set({ 'n', 'x' }, '<leader>cf', function()
  require('conform').format({
    async = true,
    lsp_format = 'fallback',
  })
end, { desc = 'Format buffer' })

-- Toggle autoformat
vim.keymap.set('n', '<leader>uf', function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat

  vim.notify(
    'Autoformat ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled')
  )
end, { desc = 'Toggle autoformat on save' })
