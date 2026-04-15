return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    enabled = false, -- 统一用 snacks.indent，减少重复渲染
    opts = {},
  },
}
