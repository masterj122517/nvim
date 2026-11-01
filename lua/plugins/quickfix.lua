-- Plugin
vim.pack.add({
  'https://github.com/stevearc/quicker.nvim',
})

-- Quickfix
require('quicker').setup({
  highlight = {
    treesitter = true,
    lsp = false,
  },

  keys = {
    {
      '>',
      function()
        require('quicker').expand({
          before = 2,
          after = 2,
          add_to_existing = true,
        })
      end,
      desc = 'Expand context',
    },
    {
      '<',
      function()
        require('quicker').collapse()
      end,
      desc = 'Collapse context',
    },
  },
})

-- Keymaps
vim.keymap.set('n', '<leader>co', function()
  require('quicker').toggle()
end, { desc = 'Toggle Quickfix' })

vim.keymap.set('n', '<leader>cl', function()
  require('quicker').toggle({ loclist = true })
end, { desc = 'Toggle Location List' })
