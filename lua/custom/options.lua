-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- General
vim.g.have_nerd_font = true
vim.g.deprecated_warnings = false
vim.g.python3_host_prog = os.getenv 'PYTHON'
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.o.termguicolors = true

-- UI
vim.o.number = true
vim.o.relativenumber = true
vim.opt.numberwidth = 2
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.showmode = false
vim.o.cmdheight = 0
vim.o.pumheight = 10
vim.o.mouse = 'a'
vim.o.scrolloff = 10
vim.o.wrap = false
vim.o.breakindent = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.smoothscroll = true
vim.opt.shortmess = 'filnxtToOScIF'

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.formatoptions:remove { 't', 'c', 'o' }

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
vim.opt.wildmenu = true
vim.opt.wildoptions:append { 'fuzzy' }
vim.opt.path:append '**'
vim.opt.grepprg = 'rg --vimgrep --no-messages --smart-case'
vim.opt.grepformat = '%f:%l:%c:%m'

-- Editing
vim.o.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.config/nvim/cache/undodir'
vim.o.confirm = true
vim.opt.whichwrap = 'b,s,<,>,h,'
vim.opt.backup = false
vim.opt.swapfile = false

-- Clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Windows
vim.o.splitright = true
vim.o.splitbelow = true

-- Timing
vim.o.updatetime = 300
vim.o.timeoutlen = 300

-- Diagnostics
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
}

-- autocomplete
-- Omni, current buffer , other windows buffers, loaded buffers, unloaded buffers   
vim.o.complete = 'o,.,w,b,u'
vim.o.autocomplete = true
vim.opt.completeopt = 'menuone,noselect,fuzzy,popup'
