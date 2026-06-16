-- gj/gk when no count
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down', silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down', silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up', silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up', silent = true })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', 's', '<nop>')
vim.keymap.set('n', 'S', '<nop>')
vim.keymap.set('n', ';', ':', {})
vim.keymap.set('v', ';', ':', {})
vim.keymap.set('n', '+', '<C-a>', { noremap = true })
vim.keymap.set('n', '_', '<C-x>', { noremap = true })
vim.keymap.set('n', ',', '@q', { noremap = true })
vim.keymap.set('n', '\\', ':nohlsearch<CR>', { noremap = true, silent = true })

-- quick delete
vim.keymap.set('n', '<bs>', '"_ciw', { noremap = true })
vim.keymap.set('i', '<c-h>', 'col(".") == col("$") ? \'<esc>"_db"_xa\' : \'<esc>"_db"_xi\'', { noremap = true, expr = true })

-- cmap
vim.keymap.set('c', '<c-a>', '<home>', { noremap = true })
vim.keymap.set('c', '<c-e>', '<end>', { noremap = true })
vim.keymap.set('c', '<C-k>', function()
  local cmdline = vim.fn.getcmdline()
  local pos = vim.fn.getcmdpos() - 1 -- 0-indexed
  vim.fn.setcmdline(cmdline:sub(1, pos))
end, { noremap = true, desc = 'Kill to end of cmdline' })
vim.keymap.set('c', '<C-b>', '<Left>', { noremap = true })
vim.keymap.set('c', '<C-f>', '<Right>', { noremap = true })
vim.keymap.set('c', '<C-d>', '<Del>', { noremap = true })

-- only change text
vim.keymap.set('v', '<BS>', '"_d', { noremap = true })
vim.keymap.set('n', 'x', '"_x', { noremap = true })
vim.keymap.set('v', 'x', '"_x', { noremap = true })
vim.keymap.set('n', 'Y', 'y$', { noremap = true })
vim.keymap.set('v', 'c', '"_c', { noremap = true })
vim.keymap.set('v', 'p', 'pgvy', { noremap = true })
vim.keymap.set('v', 'P', 'Pgvy', { noremap = true })

-- VISUAL SELECT模式 s-tab tab左右缩进
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selection down' })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selection up' })

-- 选中全文 选中{ 复制全文
vim.keymap.set('n', '<m-a>', 'ggVG', { noremap = true })
-- emacs风格快捷键
vim.keymap.set('i', '<c-a>', '<Esc>I', { noremap = true })
vim.keymap.set('i', '<c-e>', '<Esc>A', { noremap = true })
vim.keymap.set('i', '<C-k>', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_set_current_line(line:sub(1, col))
end, { noremap = true, desc = 'Kill to end of line' })

-- buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })
-- 删除当前 buffer（保持窗口不关闭）
vim.keymap.set('n', '<leader>bd', function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.cmd 'bnext' -- 切换到下一个 buffer，避免窗口留空
  vim.cmd('bdelete ' .. bufnr)
end, { desc = 'Delete Buffer' })
-- 删除除当前以外的所有 buffer
vim.keymap.set('n', '<leader>bo', function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= current then
      vim.cmd('bdelete ' .. buf)
    end
  end
end, { desc = 'Delete Other Buffers' })
-- 删除当前 buffer 并关闭窗口
vim.keymap.set('n', '<leader>bD', '<cmd>bd<cr>', { desc = 'Delete Buffer and Window' })
-- create a scrath buffer
vim.keymap.set('n', '<leader>bs', function()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_current_buf(buf)
  vim.bo[buf].filetype = 'markdown'
end, { desc = 'New scratch buffer' })

-- tabs
vim.keymap.set('n', 'te', ':tabedit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tE', ':tab split<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'th', ':-tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tl', ':+tabnext<CR>', { noremap = true, silent = true })
-- 关闭当前 tab（不关 buffer）
vim.keymap.set('n', 'tc', ':tabclose<CR>', { noremap = true, silent = true })

-- 只保留当前 tab，关掉其他所有
vim.keymap.set('n', 'to', ':tabonly<CR>', { noremap = true, silent = true })

-- 跳到第 n 个 tab，1-9
for i = 1, 9 do
  vim.keymap.set('n', 't' .. i, i .. 'gt', { noremap = true, silent = true })
end

-- quick jump between the tags using tt
vim.keymap.set('n', 'tt', '<cmd>tabnext #<cr>')

-- 跳到最后一个 tab
vim.keymap.set('n', 'tL', ':tablast<CR>', { noremap = true, silent = true })
-- 跳到第一个 tab
vim.keymap.set('n', 'tH', ':tabfirst<CR>', { noremap = true, silent = true })

-- 移动当前 tab 位置
vim.keymap.set('n', 'tmh', ':-tabmove<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tml', ':+tabmove<CR>', { noremap = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Windows Management
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- windows: sp 上下窗口 sv 左右分屏 sc关闭当前 so关闭其他 s方向切换
vim.keymap.set('n', 'sv', ':vsp<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'sp', ':sp<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'sc', ':close<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'so', ':only<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'sh', '<c-w>h', { noremap = true, silent = true })
vim.keymap.set('n', 'sl', '<c-w>l', { noremap = true, silent = true })
vim.keymap.set('n', 'sk', '<c-w>k', { noremap = true, silent = true })
vim.keymap.set('n', 'sj', '<c-w>j', { noremap = true, silent = true })
--vim.keymap.set('n', '<c-Space>', '<c-w>w', { noremap = true, silent = true })
vim.keymap.set('n', 's=', '<c-w>=', { noremap = true, silent = true })
vim.keymap.set('n', '<m-.>', "winnr() <= winnr('$') - winnr() ? '<c-w>5>' : '<c-w>5<'", { noremap = true, expr = true })
vim.keymap.set('n', '<m-,>', "winnr() <= winnr('$') - winnr() ? '<c-w>5<' : '<c-w>5>'", { noremap = true, expr = true })
vim.keymap.set('n', '<m-d>', "winnr() <= winnr('$') - winnr() ? '<c-w>5+' : '<c-w>5-'", { noremap = true, expr = true })
vim.keymap.set('n', '<m-u>', "winnr() <= winnr('$') - winnr() ? '<c-w>5-' : '<c-w>5+'", { noremap = true, expr = true })

-- 切换是否wrap
vim.keymap.set('n', '\\w', "&wrap == 1 ? ':set nowrap<cr>' : ':set wrap<cr>'", { noremap = true, expr = true })

-- space 行首行尾跳转
vim.keymap.set('n', '0', '<cmd>call v:lua.MagicMove()<cr>', { noremap = true, silent = true })
vim.keymap.set('v', '0', '<cmd>call v:lua.MagicMove("v")<cr>', { noremap = true, silent = true })
-- 驼峰转换
vim.keymap.set('v', 'T', ':call v:lua.MagicToggleHump(v:true)<CR>', { noremap = true, silent = true })
vim.keymap.set('v', 't', ':call v:lua.MagicToggleHump(v:false)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '|', '<C-\\><C-n><C-W>w', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '|', '<C-w>w', { noremap = true, silent = true })
-- 设置终端模式下的 <C-q> 关闭终端窗口
vim.api.nvim_set_keymap('t', '<C-q>', '<C-\\><C-n>:q<CR>', { noremap = true, silent = true })

-- 光标在$ 0 ^依次跳转
function MagicMove()
  local first = 1
  local head = #vim.fn.getline '.' - #vim.fn.substitute(vim.fn.getline '.', '^\\s*', '', 'G') + 1
  local before = vim.fn.col '.'
  vim.fn.execute(before == first and first ~= head and 'norm! ^' or 'norm! $')
  local after = vim.fn.col '.'
  if before == after then
    vim.fn.execute 'norm! 0'
  end
end

-- 驼峰转换 MagicToggleHump(true) 首字母大写 MagicToggleHump(false) 首字母小写
function MagicToggleHump(upperCase)
  vim.fn.execute 'normal! gv"tx'
  local w = vim.fn.getreg 't'
  local toHump = w:find '_' ~= nil
  if toHump then
    w = w:gsub('_(%w)', function(c)
      return c:upper()
    end)
  else
    w = w:gsub('(%u)', function(c)
      return '_' .. c:lower()
    end)
  end
  if w:sub(1, 1) == '_' then
    w = w:sub(2)
  end
  if upperCase then
    w = w:sub(1, 1):upper() .. w:sub(2)
  end
  vim.fn.setreg('t', w)
  vim.fn.execute 'normal! "tP'
end

require 'hacks.compile'
require 'hacks.markdown'

-- some tricks

-- Duplicate a line and comment out the first line
vim.keymap.set('n', 'yc', 'yygccp', { remap = true, desc = '[D]uplicate a line and comment out the first line' })

vim.keymap.set('v', 'gC', 'ygvgc`>p', { remap = true, desc = '[C]opy to a comment above' })

-- make it always center
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<C-d>', '<C-d>zz')

vim.keymap.set('n', 'G', 'Gzz')
