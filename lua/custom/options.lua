vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.g.python3_host_prog = os.getenv 'PYTHON'
vim.opt.wildmenu = true
vim.opt.path:append("**")

vim.g.have_nerd_font = true

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = 'a'

vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true

vim.o.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.config/nvim/cache/undodir'

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 300

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'

vim.o.cursorline = true

vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
}

vim.o.scrolloff = 10

vim.o.confirm = true

vim.opt.backspace = 'indent,eol,start'

vim.opt.whichwrap = 'b,s,<,>,h,'
vim.opt.wrap = false

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.cmdheight = 1

vim.cmd [[autocmd TermOpen term://* startinsert]]

vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]

vim.api.nvim_create_autocmd('BufEnter', { pattern = '*', command = 'silent! lcd %:p:h' })

vim.opt.shortmess = 'filnxtToOScIF'

vim.opt.formatoptions:remove { 't', 'c', 'o' }

vim.opt.numberwidth = 2

vim.opt.pumheight = 10

vim.g.deprecated_warnings = false

