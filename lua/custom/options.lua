vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 启用真彩色支持
vim.o.termguicolors = true
-- 设置环境变量启用真彩色
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
-- 设置 Python3 host 程序路径
vim.g.python3_host_prog = os.getenv 'PYTHON'
-- advance command menu
vim.opt.wildmenu = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.config/nvim/cache/undodir'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 300

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
-- vim.opt.listchars = 'tab:|\\ ,trail:▫'

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- LSP/diagnostic 性能相关
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
}

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- 设置退格键可以删除缩进、换行和插入前的字符
vim.opt.backspace = 'indent,eol,start'

-- 光标在行首/行尾时允许换行移动
vim.opt.whichwrap = 'b,s,<,>,h,'
vim.opt.wrap = false

-- 启用自动缩进
vim.opt.autoindent = true
-- 启用智能缩进
vim.opt.smartindent = true
-- 设置 tab 宽度为 2
vim.opt.tabstop = 2
-- 设置软 tab 宽度为 2
vim.opt.softtabstop = 2
-- 设置缩进宽度为 2
vim.opt.shiftwidth = 2
-- 启用 smarttab
vim.opt.smarttab = true
-- 将 tab 转为空格
vim.opt.expandtab = true

-- 禁用备份文件
vim.opt.backup = false
-- 禁用交换文件
vim.opt.swapfile = false
-- set cmdheight
vim.opt.cmdheight = 1

-- 设置不同模式下光标形状
vim.cmd [[
    let &t_SI .= '\e[5 q'       " 插入模式下使用闪烁的竖线光标
    let &t_EI .= '\e[1 q'       " 普通模式下使用稳定的块状光标
    let &t_vb = ''              " 禁用视觉响铃（屏幕闪烁）
    let &t_ut = ''              " 防止某些终端背景颜色异常
]]
-- 打开终端时自动进入插入模式
vim.cmd [[autocmd TermOpen term://* startinsert]]

-- 打开文件时恢复上次光标位置
vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]

-- 自动切换工作目录为当前 buffer 所在目录
vim.api.nvim_create_autocmd('BufEnter', { pattern = '*', command = 'silent! lcd %:p:h' })

-- 精简消息
vim.opt.shortmess = 'filnxtToOScIF'

-- 设置行号宽度
vim.opt.numberwidth = 2

-- 补全菜单最多显示10项
vim.opt.pumheight = 10

-- no deprecated warings now
vim.g.deprecated_warnings = false
