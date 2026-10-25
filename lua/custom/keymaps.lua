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


vim.keymap.set('n', '<bs>', '"_ciw', { noremap = true })
vim.keymap.set('i', '<c-h>', 'col(".") == col("$") ? \'<esc>"_db"_xa\' : \'<esc>"_db"_xi\'', { noremap = true, expr = true })


vim.keymap.set('c', '<c-a>', '<home>', { noremap = true })
vim.keymap.set('c', '<c-e>', '<end>', { noremap = true })
vim.keymap.set('c', '<C-k>', function()
  local cmdline = vim.fn.getcmdline()
  local pos = vim.fn.getcmdpos() - 1 
  vim.fn.setcmdline(cmdline:sub(1, pos))
end, { noremap = true, desc = 'Kill to end of cmdline' })
vim.keymap.set('c', '<C-b>', '<Left>', { noremap = true })
vim.keymap.set('c', '<C-f>', '<Right>', { noremap = true })
vim.keymap.set('c', '<C-d>', '<Del>', { noremap = true })


vim.keymap.set('v', '<BS>', '"_d', { noremap = true })
vim.keymap.set('n', 'x', '"_x', { noremap = true })
vim.keymap.set('v', 'x', '"_x', { noremap = true })
vim.keymap.set('n', 'Y', 'y$', { noremap = true })
vim.keymap.set('v', 'c', '"_c', { noremap = true })
vim.keymap.set('v', 'p', 'pgvy', { noremap = true })
vim.keymap.set('v', 'P', 'Pgvy', { noremap = true })


vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selection down' })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selection up' })


vim.keymap.set('n', '<m-a>', 'ggVG', { noremap = true })

vim.keymap.set('i', '<c-a>', '<Esc>I', { noremap = true })
vim.keymap.set('i', '<c-e>', '<Esc>A', { noremap = true })
vim.keymap.set('i', '<C-k>', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_set_current_line(line:sub(1, col))
end, { noremap = true, desc = 'Kill to end of line' })


vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

vim.keymap.set('n', '<leader>bd', function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.cmd 'bnext' 
  vim.cmd('bdelete ' .. bufnr)
end, { desc = 'Delete Buffer' })

vim.keymap.set('n', '<leader>bo', function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= current then
      vim.cmd('bdelete ' .. buf)
    end
  end
end, { desc = 'Delete Other Buffers' })

vim.keymap.set('n', '<leader>bD', '<cmd>bd<cr>', { desc = 'Delete Buffer and Window' })

vim.keymap.set('n', '<leader>bs', function()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_current_buf(buf)
  vim.bo[buf].filetype = 'markdown'
end, { desc = 'New scratch buffer' })


vim.keymap.set('n', 'te', ':tabedit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tE', ':tab split<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'th', ':-tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tl', ':+tabnext<CR>', { noremap = true, silent = true })

vim.keymap.set('n', 'tc', ':tabclose<CR>', { noremap = true, silent = true })


vim.keymap.set('n', 'to', ':tabonly<CR>', { noremap = true, silent = true })


for i = 1, 9 do
  vim.keymap.set('n', 't' .. i, i .. 'gt', { noremap = true, silent = true })
end


vim.keymap.set('n', 'tt', '<cmd>tabnext #<cr>')


vim.keymap.set('n', 'tL', ':tablast<CR>', { noremap = true, silent = true })

vim.keymap.set('n', 'tH', ':tabfirst<CR>', { noremap = true, silent = true })


vim.keymap.set('n', 'tmh', ':-tabmove<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tml', ':+tabmove<CR>', { noremap = true, silent = true })


vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


vim.keymap.set('n', 'sv', ':vsp<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'sp', ':sp<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'sc', ':close<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'so', ':only<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'sh', '<c-w>h', { noremap = true, silent = true })
vim.keymap.set('n', 'sl', '<c-w>l', { noremap = true, silent = true })
vim.keymap.set('n', 'sk', '<c-w>k', { noremap = true, silent = true })
vim.keymap.set('n', 'sj', '<c-w>j', { noremap = true, silent = true })

vim.keymap.set('n', 's=', '<c-w>=', { noremap = true, silent = true })
vim.keymap.set('n', '<m-.>', "winnr() <= winnr('$') - winnr() ? '<c-w>5>' : '<c-w>5<'", { noremap = true, expr = true })
vim.keymap.set('n', '<m-,>', "winnr() <= winnr('$') - winnr() ? '<c-w>5<' : '<c-w>5>'", { noremap = true, expr = true })
vim.keymap.set('n', '<m-d>', "winnr() <= winnr('$') - winnr() ? '<c-w>5+' : '<c-w>5-'", { noremap = true, expr = true })
vim.keymap.set('n', '<m-u>', "winnr() <= winnr('$') - winnr() ? '<c-w>5-' : '<c-w>5+'", { noremap = true, expr = true })

local toggle_term = {
  buf = nil,
  win = nil,
}

vim.keymap.set({ "n", "t" }, "<c-_>", function()

  if toggle_term.win and vim.api.nvim_win_is_valid(toggle_term.win) then
    local curr_win = vim.api.nvim_get_current_win()

    if curr_win == toggle_term.win then
      vim.api.nvim_win_hide(toggle_term.win)
      toggle_term.win = nil
      return
    else

      vim.api.nvim_set_current_win(toggle_term.win)
      vim.cmd("startinsert")
      return
    end
  end


  vim.cmd("belowright 10sp")
  local new_win = vim.api.nvim_get_current_win()


  if toggle_term.buf and vim.api.nvim_buf_is_valid(toggle_term.buf) then

    vim.api.nvim_win_set_buf(new_win, toggle_term.buf)
  else

    vim.cmd("terminal")
    toggle_term.buf = vim.api.nvim_get_current_buf()

    vim.bo[toggle_term.buf].filetype = "vanilla_terminal"
  end


  toggle_term.win = new_win
  vim.cmd("startinsert")
end, { silent = true })


vim.keymap.set('n', '\\w', "&wrap == 1 ? ':set nowrap<cr>' : ':set wrap<cr>'", { noremap = true, expr = true })


vim.keymap.set('n', '0', '<cmd>call v:lua.MagicMove()<cr>', { noremap = true, silent = true })
vim.keymap.set('v', '0', '<cmd>call v:lua.MagicMove("v")<cr>', { noremap = true, silent = true })

vim.keymap.set('v', 'T', ':call v:lua.MagicToggleHump(v:true)<CR>', { noremap = true, silent = true })
vim.keymap.set('v', 't', ':call v:lua.MagicToggleHump(v:false)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '|', '<C-\\><C-n><C-W>w', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '|', '<C-w>w', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<C-q>', '<C-\\><C-n>:q<CR>', { noremap = true, silent = true })


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

vim.keymap.set('n', 'yc', 'yygccp', { remap = true, desc = '[D]uplicate a line and comment out the first line' })

vim.keymap.set('v', 'gC', 'ygvgc`>p', { remap = true, desc = '[C]opy to a comment above' })

vim.keymap.set("n", "<C-g>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "G", "Gzz")


vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result and center' })

vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search result and center' })

vim.keymap.set('n', '/', 'ms/')
vim.keymap.set('n', '?', 'ms?')

vim.keymap.set('n', '`', function()
  local char = vim.fn.getcharstr()
  return '`' .. char .. 'zz'
end, { expr = true, desc = 'Jump to mark precise and center' })

vim.keymap.set('n', "'", function()
  local char = vim.fn.getcharstr()
  return "'" .. char .. 'zz'
end, { expr = true, desc = 'Jump to mark line and center' })

local magic_insertpair = function(char) 
  local pair_close = { ['('] = ')', ['['] = ']', ['{'] = '}' }
  local close_set = { [')'] = true, [']'] = true, ['}'] = true, ['"'] = true, ["'"] = true, ['`'] = true }
  local quote_set = { ['"'] = true, ["'"] = true, ['`'] = true }
  local col = vim.fn.col('.')
  local after = vim.api.nvim_get_current_line():sub(col, col)
  local should_pair = after == '' or after == ';' or close_set[after]

  if pair_close[char] then
    if should_pair then return char .. pair_close[char] .. '<Left>' end
    return char
  end

  if after == char then return '<Right>' end
  if quote_set[char] and should_pair then return char .. char .. '<Left>' end
  return char
end

local function magic_delpair() 
  local line, col = vim.api.nvim_get_current_line(), vim.fn.col('.')
  if col > 1 and vim.tbl_contains({ ')', ']', '}', '"', "'", '`' }, line:sub(col, col))
    and vim.tbl_contains({ '(', '[', '{', '"', "'", '`' }, line:sub(col - 1, col - 1)) then
    return '<Del><BS>'
  end
  return '<BS>'
end

for _, c in ipairs({ '(', '[', '{', ')', ']', '}', '"', "'", '`' }) do
  vim.keymap.set('i', c, function() return magic_insertpair(c) end, { expr = true, noremap = true })
end
vim.keymap.set('i', '<BS>', magic_delpair, { expr = true, noremap = true })

local multicursor_ns = vim.api.nvim_create_namespace 'nvim.multicursor'
local multicursor_group = vim.api.nvim_create_augroup('custom.multicursor', { clear = true })

local function multicursor_insert(key)
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' then
    return key
  end

  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd('InsertLeave', {
    group = multicursor_group,
    buffer = buf,
    once = true,
    callback = function()
      vim.schedule(function()
        vim.api.nvim_buf_clear_namespace(buf, multicursor_ns, 0, -1)
      end)
    end,
  })
  return 'Q' .. key
end

vim.keymap.set('x', 'I', function()
  return multicursor_insert 'I'
end, { expr = true, desc = 'Native multicursor insert at line starts' })
vim.keymap.set('x', 'A', function()
  return multicursor_insert 'A'
end, { expr = true, desc = 'Native multicursor append at line ends' })


vim.keymap.set('n', '<leader><C-l>', function()
  vim.api.nvim_buf_clear_namespace(0, multicursor_ns, 0, -1)
  vim.cmd.redraw()
end, { desc = 'Clear native multicursors' })
