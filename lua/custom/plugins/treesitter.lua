return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'java', 'python', 'rust', 'go', 'markdown', 'markdown_inline' },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
  },
}
