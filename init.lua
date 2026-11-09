vim.opt.runtimepath:prepend(vim.fn.expand('~/programming/kataware.nvim'))

require "custom"
require "plugins"
require('kataware').setup { transparent = true }
vim.cmd.colorscheme 'kataware'
