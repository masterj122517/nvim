local G = {}

G.g = vim.g
G.b = vim.b
G.o = vim.o
G.v = vim.v
G.fn = vim.fn
G.api = vim.api
G.opt = vim.opt

function G.map(maps)
  for _, map in pairs(maps) do
    G.api.nvim_set_keymap(map[1], map[2], map[3], map[4])
  end
end

G.g.mapleader = " "

G.map({
  -- 设置s t 无效 ;=: ,重复上一次宏操作
  { "n", "s", "<nop>", {} },
  { "n", ";", ":", {} },
  { "v", ";", ":", {} },
  { "n", "+", "<c-a>", { noremap = true } },
  { "n", "_", "<c-x>", { noremap = true } },
  { "n", ",", "@q", { noremap = true } },

  { "n", "\\", ":nohlsearch<CR>", { noremap = true, silent = true } },

  -- 快速删除
  { "n", "<bs>", '"_ciw', { noremap = true } },
  { "i", "<c-h>", 'col(".") == col("$") ? \'<esc>"_db"_xa\' : \'<esc>"_db"_xi\'', { noremap = true, expr = true } },

  -- ,打断
  { "n", "<c-j>", "f,a<cr><esc>", { noremap = true } },
  { "i", "<c-j>", "<esc>f,a<cr>", { noremap = true } },

  -- cmap
  { "c", "<c-a>", "<home>", { noremap = true } },
  { "c", "<c-e>", "<end>", { noremap = true } },
  { "c", "<up>", "<c-p>", { noremap = true } },
  { "c", "<down>", "<c-n>", { noremap = true } },

  -- only change text
  { "v", "<BS>", '"_d', { noremap = true } },
  { "n", "x", '"_x', { noremap = true } },
  { "v", "x", '"_x', { noremap = true } },
  { "n", "Y", "y$", { noremap = true } },
  { "v", "c", '"_c', { noremap = true } },
  { "v", "p", "pgvy", { noremap = true } },
  { "v", "P", "Pgvy", { noremap = true } },

  -- Q退出
  { "n", "Q", ":q!<cr>", { noremap = true, silent = true } },
  { "n", "S", ":call v:lua.MagicSave()<cr>", { noremap = true, silent = true } },

  -- VISUAL SELECT模式 s-tab tab左右缩进
  { "v", "<", "<gv", { noremap = true } },
  { "v", ">", ">gv", { noremap = true } },
  { "v", "<s-tab>", "<gv", { noremap = true } },
  { "v", "<tab>", ">gv", { noremap = true } },

  -- 选中全文 选中{ 复制全文
  { "n", "<m-a>", "ggVG", { noremap = true } },
  { "n", "<m-s>", "vi{", { noremap = true } },

  -- emacs风格快捷键 清空一行
  { "i", "<c-a>", "<Esc>I", { noremap = true } },
  { "i", "<c-e>", "<Esc>A", { noremap = true } },

  -- alt + 上 下移动行
  { "n", "<m-k>", ":m .-2<cr>", { noremap = true, silent = true } },
  { "n", "<m-j>", ":m .+1<cr>", { noremap = true, silent = true } },
  { "v", "<m-k>", ":m '<-2<cr>gv", { noremap = true, silent = true } },
  { "v", "<m-j>", ":m '>+1<cr>gv", { noremap = true, silent = true } },

  -- alt + key 操作
  -- { "i", "<m-d>", '<Esc>"_ciw', { noremap = true } },
  -- { "i", "<m-o>", "<Esc>o", { noremap = true } },
  -- { "i", "<m-O>", "<Esc>O", { noremap = true } },

  -- windows: sp 上下窗口 sv 左右分屏 sc关闭当前 so关闭其他 s方向切换
  -- { "n", "sv", ":vsp<cr><c-w>w", { noremap = true, silent = true } },
  -- { "n", "sp", ":sp<cr><c-w>w", { noremap = true, silent = true } },
  { "n", "sv", ":vsp<cr>", { noremap = true, silent = true } },
  { "n", "sp", ":sp<cr>", { noremap = true, silent = true } },
  { "n", "sc", ":close<cr>", { noremap = true, silent = true } },
  { "n", "so", ":only<cr>", { noremap = true, silent = true } },
  { "n", "sh", "<c-w>h", { noremap = true, silent = true } },
  { "n", "sl", "<c-w>l", { noremap = true, silent = true } },
  { "n", "sk", "<c-w>k", { noremap = true, silent = true } },
  { "n", "sj", "<c-w>j", { noremap = true, silent = true } },
  { "n", "<c-Space>", "<c-w>w", { noremap = true, silent = true } },
  { "n", "s=", "<c-w>=", { noremap = true, silent = true } },
  { 'n', "<m-.>", "winnr() <= winnr('$') - winnr() ? '<c-w>5>' : '<c-w>5<'", { noremap = true, expr = true } },
  { 'n', "<m-,>", "winnr() <= winnr('$') - winnr() ? '<c-w>5<' : '<c-w>5>'", { noremap = true, expr = true } },
  { 'n', "<m-d>", "winnr() <= winnr('$') - winnr() ? '<c-w>5+' : '<c-w>5-'", { noremap = true, expr = true } },
  { 'n', "<m-u>", "winnr() <= winnr('$') - winnr() ? '<c-w>5-' : '<c-w>5+'", { noremap = true, expr = true } },

  -- Enable terminal mode and allow Esc to exit
  { "t", "<Esc>", "<C-\\><C-n>", { noremap = true } },

  -- buffers
  { "n", "te", ":tabedit<CR>", { noremap = true, silent = true } },
  { "n", "th", ":-tabnext<CR>", { noremap = true, silent = true } },
  { "n", "tl", ":+tabnext<CR>", { noremap = true, silent = true } },
  { "n", "tmh", ":-tabmove<CR>", { noremap = true, silent = true } },
  { "n", "tml", ":+tabmove<CR>", { noremap = true, silent = true } },
  { "n", "W", ":bw<cr>", { noremap = true, silent = true } },
  { "n", "ss", ":bn<cr>", { noremap = true, silent = true } },

  -- tt 打开一个10行大小的终端
  { "n", "tt", ":below 10sp | term<cr>", { noremap = true, silent = true } },

  -- 切换是否wrap
  { "n", "\\w", "&wrap == 1 ? ':set nowrap<cr>' : ':set wrap<cr>'", { noremap = true, expr = true } },

  -- space 行首行尾跳转
  -- { "n", "0", ":call v:lua.MagicMove()<cr>", { noremap = true, silent = true } },
  -- { "v", "0", ":call v:lua.MagicMove()<cr>", { noremap = true, silent = true } },

  -- 驼峰转换
  -- { "v", "T", ":call v:lua.MagicToggleHump(v:true)<CR>", { noremap = true, silent = true } },
  -- { "v", "t", ":call v:lua.MagicToggleHump(v:false)<CR>", { noremap = true, silent = true } },
})

-- 光标在$ 0 ^依次跳转
-- function MagicMove()
--   local first = 1
--   local head = #G.fn.getline(".") - #G.fn.substitute(G.fn.getline("."), "^\\s*", "", "G") + 1
--   local before = G.fn.col(".")
--   G.fn.execute(before == first and first ~= head and "norm! ^" or "norm! $")
--   local after = G.fn.col(".")
--   if before == after then
--     G.fn.execute("norm! 0")
--   end
-- end

-- 1 当目录不存在时 先创建目录, 2 当前文件是acwrite时, 用sudo保存
function MagicSave()
  if G.fn.empty(G.fn.glob(G.fn.expand("%:p:h"))) then
    G.fn.system("mkdir -p " .. G.fn.expand("%:p:h"))
  end
  if G.o.buftype == "acwrite" then
    G.fn.execute("w !sudo tee > /dev/null %")
  else
    G.fn.execute("w")
  end
end

-- 驼峰转换 MagicToggleHump(true) 首字母大写 MagicToggleHump(false) 首字母小写
function MagicToggleHump(upperCase)
  G.fn.execute('normal! gv"tx')
  local w = G.fn.getreg("t")
  local toHump = w:find("_") ~= nil
  if toHump then
    w = w:gsub("_(%w)", function(c)
      return c:upper()
    end)
  else
    w = w:gsub("(%u)", function(c)
      return "_" .. c:lower()
    end)
  end
  if w:sub(1, 1) == "_" then
    w = w:sub(2)
  end
  if upperCase then
    w = w:sub(1, 1):upper() .. w:sub(2)
  end
  G.fn.setreg("t", w)
  G.fn.execute('normal! "tP')
end

-- close win below
vim.keymap.set("n", "<C-q>", function()
	require("trouble").close()
	local wins = vim.api.nvim_tabpage_list_wins(0)
	if #wins > 1 then
		-- 直接调用 vim.cmd 实现关闭窗口的操作
		vim.cmd([[silent! wincmd j | q]])
	end
end, { noremap = true, silent = true })

-- 设置 ~ 键映射在两个窗口之间切换
vim.api.nvim_set_keymap("t", "|", "<C-\\><C-n><C-W>w", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "|", "<C-w>w", { noremap = true, silent = true })

-- 设置终端模式下的 <C-q> 关闭终端窗口
vim.api.nvim_set_keymap("t", "<C-q>", "<C-\\><C-n>:q<CR>", { noremap = true, silent = true })

local ctrlu = require("custom.ctrlu").ctrlu
vim.keymap.set("i", "<C-a>", ctrlu, { silent = true })

