vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.g.python3_host_prog = os.getenv("PYTHON")
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.pumheight = 10
vim.opt.encoding = "utf-8"
-- vim.opt.conceallevel = 0 -- 文本隐藏
vim.opt.clipboard = "unnamed,unnamedplus"
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.timeoutlen = 400
vim.opt.backspace = "indent,eol,start"
vim.opt.whichwrap = "b,s,<,>,h,"
vim.opt.mouse = "a"
vim.opt.vb = true
vim.opt.hidden = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/cache/undodir"
vim.opt.viminfo = "!,'10000,<50,s10,h"
--vim.opt.foldenable = true
--vim.opt.foldmethod = 'manual'
vim.opt.viewdir = os.getenv("HOME") .. "/.config/nvim/cache/viewdir"
vim.opt.updatetime = 300
vim.opt.cmdheight = 1
vim.opt.scrolloff = 5
vim.opt.shortmess = "filnxtToOScIF"
vim.opt.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.cul = true
vim.opt.signcolumn = "yes"
vim.opt.fillchars = "fold:-,stlnc:#,eob: ,foldsep:="
vim.o.formatoptions = vim.o.formatoptions:gsub("tc", ""):gsub("o", "")

-- 设置光标
vim.cmd([[
    let &t_SI .= '\e[5 q'
    let &t_EI .= '\e[1 q'
    let &t_vb = ''
    let &t_ut = ''
]])

--vim.opt.foldtext = 'v:lua.MagicFoldText()'

-- function MagicFoldText()
--     local spacetext = ("        "):sub(0, G.opt.shiftwidth:get())
--     local line = G.fn.getline(G.v.foldstart):gsub("\t", spacetext)
--     local folded = G.v.foldend - G.v.foldstart + 1
--     local findresult = line:find('%S')
--     if not findresult then return '+ folded ' .. folded .. ' lines ' end
--     local empty = findresult - 1
--     local funcs = {
--         [0] = function(_) return '' .. line end,
--         [1] = function(_) return '+' .. line:sub(2) end,
--         [2] = function(_) return '+ ' .. line:sub(3) end,
--         [-1] = function(c)
--             local result = ' ' .. line:sub(c + 1)
--             local foldednumlen = #tostring(folded)
--             for _ = 1, c - 2 - foldednumlen do result = '-' .. result end
--             return '+' .. folded .. result
--         end,
--     }
--     return funcs[empty <= 2 and empty or -1](empty) .. ' folded ' .. folded .. ' lines '
-- end

vim.cmd([[autocmd TermOpen term://* startinsert]])
vim.cmd([[hi NonText ctermfg=gray guifg=grey10]])

-- set spell when open .md
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal spell" })
-- remember cursor's location
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
-- cd to buffers
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h" })


-- make all keymaps silent by default
local keymap_set = vim.keymap.set
---@diagnostic disable-next-line: duplicate-set-field
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end
