-- Mini Config Spec

vim.keymap.set("n", "-", ":Explore<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<C-f>", ":find ", { desc = "Find file" })
vim.keymap.set("n", "<leader>co", ":copen<CR>", {desc = "Open QuickFix List"})


-- Completions
vim.keymap.set("i", "<C-o>", function()
  vim.lsp.completion.get()
end, { desc = "Trigger LSP completion" })
vim.keymap.set('i', '<CR>', function()
  local info = vim.fn.complete_info({ 'selected' })
  if vim.fn.pumvisible() == 1 and info.selected >= 0 then
    return '<C-y>'
  end
  return '<C-e><CR>'
end, {
  expr = true,
  desc = 'Accept completion or insert newline',
})


--- General Config Spec
---------------------------------------------------------
-- Navigation
-- Move by display lines and keep jumps centered
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down', silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = 'Down', silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up', silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = 'Up', silent = true })

vim.keymap.set('n', '0', '<cmd>call v:lua.MagicMove()<cr>', { noremap = true, silent = true })
vim.keymap.set('v', '0', '<cmd>call v:lua.MagicMove("v")<cr>', { noremap = true, silent = true })

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

vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "G", "Gzz")


-- Search and marks
-- Clear search highlights and center search or mark jumps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '\\', ':nohlsearch<CR>', { noremap = true, silent = true })

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

-- General mappings
-- Customize default keys and shortcuts
vim.keymap.set('n', 's', '<nop>')
vim.keymap.set('n', 'S', '<nop>')
vim.keymap.set('v', 's', '<nop>')
vim.keymap.set('v', 'S', '<nop>')
vim.keymap.set('n', ';', ':', {})
vim.keymap.set('v', ';', ':', {})
vim.keymap.set('n', '+', '<C-a>', { noremap = true })
vim.keymap.set('n', '_', '<C-x>', { noremap = true })
vim.keymap.set('n', ',', '@q', { noremap = true })

vim.keymap.set('n', '<m-a>', 'ggVG', { noremap = true })


-- Editing and clipboard
-- Edit text without overwriting registers when possible
vim.keymap.set('n', '<bs>', '"_ciw', { noremap = true })
vim.keymap.set('i', '<c-h>', 'col(".") == col("$") ? \'<esc>"_db"_xa\' : \'<esc>"_db"_xi\'',
  { noremap = true, expr = true })

vim.keymap.set('v', '<BS>', '"_d', { noremap = true })
vim.keymap.set('n', 'x', '"_x', { noremap = true })
vim.keymap.set('v', 'x', '"_x', { noremap = true })
vim.keymap.set('n', 'Y', 'y$', { noremap = true })
vim.keymap.set('v', 'c', '"_c', { noremap = true })
vim.keymap.set('v', 'p', 'pgvy', { noremap = true })
vim.keymap.set('v', 'P', 'Pgvy', { noremap = true })

vim.keymap.set('i', '<c-a>', '<Esc>I', { noremap = true })
vim.keymap.set('i', '<c-e>', '<Esc>A', { noremap = true })
vim.keymap.set('i', '<C-k>', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  vim.api.nvim_set_current_line(line:sub(1, col))
end, { noremap = true, desc = 'Kill to end of line' })


-- Visual selection
-- Indent and move selected lines
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selection down' })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move selection up' })


-- Command line
-- Use readline-style command-line editing
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


-- Buffers
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Next Buffer' })

-- Tabs
-- Manage tab pages
vim.keymap.set('n', 'te', ':tab split<CR>', { noremap = true, silent = true })
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


-- Windows and splits
-- Navigate and resize splits
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

vim.api.nvim_set_keymap('t', '|', '<C-\\><C-n><C-W>w', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '|', '<C-w>w', { noremap = true, silent = true })

vim.api.nvim_set_keymap('t', '<C-q>', '<C-\\><C-n>:q<CR>', { noremap = true, silent = true })
-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
  desc = 'Open diagnostic location list',
})

vim.keymap.set('n', '<leader>Q', vim.diagnostic.setqflist, {
  desc = 'Open diagnostic quickfix list',
})

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Text helpers
vim.keymap.set('n', '\\w', "&wrap == 1 ? ':set nowrap<cr>' : ':set wrap<cr>'", { noremap = true, expr = true })

vim.keymap.set('v', 'T', ':call v:lua.MagicToggleHump(v:true)<CR>', { noremap = true, silent = true })
vim.keymap.set('v', 't', ':call v:lua.MagicToggleHump(v:false)<CR>', { noremap = true, silent = true })

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

vim.keymap.set('n', 'yc', 'yygccp', { remap = true, desc = '[D]uplicate a line and comment out the first line' })

-- Native multicursor
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

vim.keymap.set('c', '/', function()
  local cmdtype = vim.fn.getcmdtype()
  local cmdline = vim.fn.getcmdline()

  if (cmdtype == '/' or cmdtype == '?')
      and cmdline == '' then
    return '<C-c><Esc>/\\%V'
  end

  return '/'
end, { expr = true })

-- g?: Web search
vim.keymap.set('n', 'g??', function()
  vim.ui.open(('https://google.com/search?q=%s'):format(vim.fn.expand('<cword>')))
end)
vim.keymap.set('x', 'g??', function()
  vim.ui.open(('https://google.com/search?q=%s'):format(vim.trim(table.concat(
    vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { type = vim.fn.mode() }), ' '))))
  vim.api.nvim_input('<esc>')
end)

vim.keymap.set('n', 'cdg', function()
  local root = vim.fs.root(0, '.git')
  if not root then
    return
  end

  vim.cmd('lcd ' .. vim.fn.fnameescape(root))
  vim.cmd('verbose pwd')
end, { desc = 'CD to Git root' })

vim.keymap.set('n', 'cdn', '<cmd>lcd %:h | verbose pwd<CR>', {
  desc = "CD to current file's directory",
})

vim.keymap.set('n', 'cdu', '<cmd>lcd .. | verbose pwd<CR>', {
  desc = 'CD to parent directory',
})

vim.keymap.set('n', 'cd-', '<cmd>lcd - | verbose pwd<CR>', {
  desc = 'CD to previous directory',
})

vim.keymap.set('n', 'g>', '<cmd>40messages<CR>', {
  desc = 'Show recent messages',
})

vim.keymap.set('i', '<C-y>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-y>'
  end

  local col = vim.fn.virtcol('.')
  local line = vim.fn.getline(vim.fn.line('.') - 1)
  local pattern = [[\%]] .. col .. [[v\%(\k\+\|.\)]]

  return vim.fn.matchstr(line, pattern)
end, {
  expr = true,
  desc = 'Copy word from line above',
})


vim.keymap.set('n', 'n', function()
  return vim.v.searchforward == 1 and 'n' or 'N'
end, { expr = true })

vim.keymap.set('n', 'N', function()
  return vim.v.searchforward == 1 and 'N' or 'n'
end, { expr = true })

vim.keymap.set('n', 'vK', '<C-\\><C-N><Cmd>help!<CR>', {
  desc = 'Open Neovim help for word under cursor',
})

local function search_cword(whole_word)
  local word = vim.fn.expand('<cword>')
  if word == '' then return end

  local escaped = vim.fn.escape(word, [[/\]])
  local pattern = [[\V]] .. escaped

  if whole_word then
    pattern = [[\V\<]] .. escaped .. [[\>]]
  end

  vim.fn.setreg('/', pattern)
  vim.fn.histadd('/', pattern)
  vim.opt.hlsearch = true
end

vim.keymap.set('n', '*', function()
  search_cword(true)
end, { desc = 'Highlight word under cursor' })

vim.keymap.set('n', '#', function()
  search_cword(true)
end, { desc = 'Highlight word under cursor' })

vim.keymap.set('n', 'g*', function()
  search_cword(false)
end, { desc = 'Highlight partial matches' })

vim.keymap.set('n', 'g#', function()
  search_cword(false)
end, { desc = 'Highlight partial matches' })

vim.cmd [[
func! s:trimws_ml(s) abort "trim whitespace across multiple lines
  return substitute(a:s, '^\_s*\(.\{-}\)\_s*$', '\1', '')
endf
"why?
" - repeatable
" - faster/more convenient than visual-replace
" - does not modify ' mark
" - DWIM behavior for linewise => characterwise
let s:rr_reg = '"'
func! s:set_reg(reg_name) abort
  let s:rr_reg = a:reg_name
endf
func! s:replace_without_yank(type) abort
  let rr_orig = getreg(s:rr_reg, 1) "save registers and types to restore later.
  let rr_type = getregtype(s:rr_reg)
  let sel_save = &selection
  let &selection = "inclusive"
  let replace_curlin = (1==col("'[") && (col('$')==1 || col('$')==(col("']")+1)) && line("'[")==line("']"))

  if a:type ==? 'line' || replace_curlin
    exe "keepjumps normal! '[V']\"".s:rr_reg."P"
  elseif a:type ==? 'block'
    exe "keepjumps normal! `[\<C-V>`]\"".s:rr_reg."P"
  else
    "DWIM: if pasting linewise contents in a _characterwise_ motion, trim
    "      surrounding whitespace from the content to be pasted.
    if rr_type ==# "V"
      call setreg(s:rr_reg, s:trimws_ml(rr_orig), "v")
    endif
    exe "keepjumps normal! `[v`]\"".s:rr_reg."P"
  endif

  let &selection = sel_save
  call setreg(s:rr_reg, rr_orig, rr_type)
endf

nnoremap <silent> dr  :<C-u>call <sid>set_reg(v:register)<bar>set opfunc=<sid>replace_without_yank<CR>g@
nnoremap <silent> drr :<C-u>call <sid>set_reg(v:register)<cr>0:<C-u>set opfunc=<sid>replace_without_yank<CR>g@$
]]

-- buffers
vim.cmd [[
func! s:compare_numbers(n1, n2) abort
  return a:n1 == a:n2 ? 0 : a:n1 > a:n2 ? 1 : -1
endfunc

func! s:compare_bufs(b1, b2) abort
  let b1_visible = index(tabpagebuflist(), a:b1) >= 0
  let b2_visible = index(tabpagebuflist(), a:b2) >= 0

  if bufloaded(a:b1)
    if bufloaded(a:b2)
      if b1_visible == b2_visible
        return s:compare_numbers(a:b1, a:b2)
      endif
      return s:compare_numbers(b2_visible, b1_visible)
    endif
    return 1
  endif
  return !bufloaded(a:b2) ? s:compare_numbers(a:b1, a:b2) : 1
endf

func! s:buf_is_valid(bnr) abort
  return buflisted(a:bnr)
    \ && (getbufvar(a:bnr, "&buftype") ==# ""
    \     || getbufvar(a:bnr, "&buftype") ==# "help")
    \ && a:bnr != bufnr("%")
    \ && index(tabpagebuflist(), a:bnr) == -1
    \ && !(getbufvar(a:bnr, "&modified")
    \      && getbufvar(a:bnr, "&readonly"))
endfunc

func! s:buf_find_unused() abort
  for i in range(1, bufnr('$'))
    if bufexists(i)
          \ && index(tabpagebuflist(), i) == -1
          \ && nvim_buf_get_changedtick(i) <= 2
          \ && buflisted(i)
          \ && bufname(i) ==# ''
          \ && getbufvar(i, '&buftype') ==# ''
      return i
    endif
  endfor
  return 0
endf

func! s:buf_new() abort
  let newbuf = s:buf_find_unused()
  if newbuf == 0
    enew
  else
    exe 'buffer' newbuf
  endif
endf

func! s:buf_find_valid_next_bufs() abort
  let validbufs = filter(range(1, bufnr('$')), '<SID>buf_is_valid(v:val)')
  call sort(validbufs, '<SID>compare_bufs')
  return validbufs
endf

func! s:buf_switch_to_altbuff() abort
  if buflisted(bufnr("#")) && bufnr("#") != bufnr("%")
    buffer #
    return 1
  endif

  let lastbnr = bufnr('$')
  if s:buf_is_valid(lastbnr)
    exe 'buffer '.lastbnr
    return 1
  endif

  let validbufs = s:buf_find_valid_next_bufs()
  if len(validbufs) > 0
    exe 'buffer '.validbufs[0]
    return 1
  endif

  return 0
endf

func! s:buf_kill(mercy) abort
  let origbuf = bufnr("%")
  let origbufname = bufname(origbuf)

  if a:mercy && &modified
    echom 'Buffer has unsaved changes (use count to force)'
    return
  endif

  if !s:buf_switch_to_altbuff()
    call s:buf_new()
  endif

  if !empty(origbufname)
    silent! exe 'argdelete '.fnameescape(origbufname)
  endif

  if buflisted(origbuf) || bufloaded(origbuf)
    exe 'bdelete! '.origbuf
  endif
endf

nnoremap <expr><silent> <leader>bd
      \ ':<C-u>call <SID>buf_kill('. !v:count .')<CR>'
]]

-- Delete other loaded buffers
vim.keymap.set('n', '<leader>bo', function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and buf ~= current then
      vim.cmd('bdelete ' .. buf)
    end
  end
end, { desc = 'Delete Other Buffers' })

-- New Markdown scratch buffer
vim.keymap.set('n', '<leader>bs', function()
  local buf = vim.api.nvim_create_buf(true, true)
  vim.api.nvim_set_current_buf(buf)
  vim.bo[buf].filetype = 'markdown'
end, { desc = 'New Scratch Buffer' })
-- terminal
local toggle_term = {
  win = nil,
  buf = nil,
}

local function toggle_my_terminal()
  -- 1. If the terminal window is visible, hide it or focus it depending on current focus
  if toggle_term.win and vim.api.nvim_win_is_valid(toggle_term.win) then
    local curr_win = vim.api.nvim_get_current_win()
    -- If inside the terminal window, hide it
    if curr_win == toggle_term.win then
      vim.api.nvim_win_hide(toggle_term.win)
      toggle_term.win = nil
      return
    else
      -- If open but unfocused, move focus to it (similar to snacks.terminal.focus)
      vim.api.nvim_set_current_win(toggle_term.win)
      vim.cmd 'startinsert'
      return
    end
  end

  -- 2. Split a new window downwards with a fixed height of 10 lines
  vim.cmd 'belowright 10sp'
  local new_win = vim.api.nvim_get_current_win()

  -- 3. Check if the terminal buffer exists and is valid
  if toggle_term.buf and vim.api.nvim_buf_is_valid(toggle_term.buf) then
    -- Reuse existing buffer
    vim.api.nvim_win_set_buf(new_win, toggle_term.buf)
  else
    -- Create a brand new terminal and store its buffer ID
    vim.cmd 'terminal'
    toggle_term.buf = vim.api.nvim_get_current_buf()
    -- Set custom filetype to avoid default terminal options pollution
    vim.bo[toggle_term.buf].filetype = 'vanilla_terminal'
  end

  -- 4. Record the current bound window ID and enter insert mode
  toggle_term.win = new_win
  vim.cmd 'startinsert'
end

-- Bind both keys to handle different terminal tracking definitions
vim.keymap.set({ 'n', 't' }, '<c-/>', toggle_my_terminal, { silent = true })
vim.keymap.set({ 'n', 't' }, '<c-_>', toggle_my_terminal, { silent = true })
