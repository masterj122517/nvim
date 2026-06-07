return {
  'zk-org/zk-nvim',
  name = 'zk',
  opts = {
    -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
    -- or select" (`vim.ui.select`).
    picker = 'telescope',

    lsp = {
      -- `config` is passed to `vim.lsp.start(config)`
      config = {
        name = 'zk',
        cmd = { 'zk', 'lsp' },
        filetypes = { 'markdown' },

        on_attach = function(client, bufnr)
          local opts = { buffer = bufnr, silent = true }
          -- 快捷键映射：创建、查找笔记
          vim.keymap.set('n', '<leader>zn', "<cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
          vim.keymap.set('n', '<leader>zf', '<cmd>ZkNotes<CR>', opts)
          vim.keymap.set('n', '<leader>zt', '<cmd>ZkTags<CR>', opts)
          -- 在视觉模式下将选中文本作为标题创建新笔记并插入链接
          vim.keymap.set('v', '<leader>zn', ":'<,'>ZkNewFromTitleSelection<CR>", opts)

          vim.keymap.set('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', opts)
        end,
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
      },
    },
  },
}
