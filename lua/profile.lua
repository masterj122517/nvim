vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

local G = require('G')

G.g.python3_host_prog = os.getenv('PYTHON') -- export PYTHON=$(which python3)
G.opt.showcmd = true
G.opt.encoding = 'utf-8'
G.opt.wildmenu = true
G.opt.pumheight = 10
G.opt.conceallevel = 0
G.opt.clipboard = 'unnamed,unnamedplus'
G.opt.hlsearch = true
G.opt.showmatch = true
G.opt.incsearch = true
G.opt.inccommand = ''
G.opt.ignorecase = true
G.opt.smartcase = true
G.opt.timeoutlen = 400
G.opt.backspace = 'indent,eol,start'
G.opt.whichwrap = 'b,s,<,>,h,'
G.opt.mouse = 'a'
G.opt.vb = true
G.opt.hidden = true
G.opt.autoindent = true
G.opt.smartindent = true
G.opt.tabstop = 4
G.opt.softtabstop = 4
G.opt.shiftwidth = 4
G.opt.smarttab = true
G.opt.expandtab = true
G.opt.backup = false
G.opt.swapfile = false
G.opt.wrap = false
G.opt.undofile = true
G.opt.undodir = os.getenv('HOME') .. '/.config/nvim/cache/undodir'
G.opt.viminfo = "!,'10000,<50,s10,h"
G.opt.foldenable = true
G.opt.foldmethod = 'manual'
G.opt.viewdir = os.getenv('HOME') .. '/.config/nvim/cache/viewdir'
G.opt.foldtext = 'v:lua.MagicFoldText()'
G.opt.cmdheight = 1
G.opt.updatetime = 300
G.opt.shortmess = 'filnxtToOScIF'
G.opt.scrolloff = 5
G.opt.showmode = false
G.opt.number = true
G.opt.relativenumber = true
G.opt.numberwidth = 2
G.opt.cul = true
G.opt.signcolumn = 'yes'
G.opt.fillchars = 'fold:-,stlnc:#,eob: ,foldsep:='

G.cmd([[
    let &t_SI .= '\e[5 q'
    let &t_EI .= '\e[1 q'
    let &t_vb = ''
    let &t_ut = ''
]])

function MagicFoldText()
    local spacetext = ("        "):sub(0, G.opt.shiftwidth:get())
    local line = G.fn.getline(G.v.foldstart):gsub("\t", spacetext)
    local folded = G.v.foldend - G.v.foldstart + 1
    local findresult = line:find('%S')
    if not findresult then return '+ folded ' .. folded .. ' lines ' end
    local empty = findresult - 1
    local funcs = {
        [0] = function(_) return '' .. line end,
        [1] = function(_) return '+' .. line:sub(2) end,
        [2] = function(_) return '+ ' .. line:sub(3) end,
        [-1] = function(c)
            local result = ' ' .. line:sub(c + 1)
            local foldednumlen = #tostring(folded)
            for _ = 1, c - 2 - foldednumlen do result = '-' .. result end
            return '+' .. folded .. result
        end,
    }
    return funcs[empty <= 2 and empty or -1](empty) .. ' folded ' .. folded .. ' lines '
end

vim.g.terminal_color_0  = '#000000'
vim.g.terminal_color_1  = '#FF5555'
vim.g.terminal_color_2  = '#50FA7B'
vim.g.terminal_color_3  = '#F1FA8C'
vim.g.terminal_color_4  = '#BD93F9'
vim.g.terminal_color_5  = '#FF79C6'
vim.g.terminal_color_6  = '#8BE9FD'
vim.g.terminal_color_7  = '#BFBFBF'
vim.g.terminal_color_8  = '#4D4D4D'
vim.g.terminal_color_9  = '#FF6E67'
vim.g.terminal_color_10 = '#5AF78E'
vim.g.terminal_color_11 = '#F4F99D'
vim.g.terminal_color_12 = '#CAA9FA'
vim.g.terminal_color_13 = '#FF92D0'
vim.g.terminal_color_14 = '#9AEDFE'

vim.cmd([[autocmd TermOpen term://* startinsert]])

-- set spell when open .md
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal spell", })
-- remember cursor's location
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
-- cd to buffers
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h", })
