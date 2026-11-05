vim.opt.runtimepath:prepend(vim.fn.expand('~/programming/kataware.nvim'))

require 'custom.options'
require 'custom.keymaps'
require	'custom.autocmd'
require	'hacks.compile'
require	'hacks.markdown'

require('kataware').setup { transparent = false }
vim.cmd.colorscheme 'musubi'

