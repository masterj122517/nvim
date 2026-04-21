return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'java', 'python', 'rust', 'go', 'markdown', 'markdown_inline', 'haskell' },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    -- treesitter 缩进在大文件上比较吃性能，这里关闭
    indent = { enable = false },
  },
}
