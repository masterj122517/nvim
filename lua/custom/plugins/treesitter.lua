local parsers = {
  'angular',
  'astro',
  'bash',
  'c',
  'cpp',
  'css',
  'diff',
  'go',
  'graphql',
  'haskell',
  'html',
  'java',
  'javascript',
  'jsdoc',
  'json',
  'lua',
  'markdown',
  'markdown_inline',
  'prisma',
  'python',
  'query',
  'rust',
  'scss',
  'svelte',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'vue',
  'yaml',
}

return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local treesitter = require 'nvim-treesitter'
    local installed = treesitter.get_installed 'parsers'
    local missing = vim.tbl_filter(function(parser)
      return not vim.list_contains(installed, parser)
    end, parsers)
    if #missing > 0 then
      treesitter.install(missing)
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('masterjVim_treesitter', { clear = true }),
      callback = function(event)
        pcall(vim.treesitter.start, event.buf)
      end,
    })
  end,
}
