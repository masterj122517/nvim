local function augroup(name)
  return vim.api.nvim_create_augroup('masterjVim_' .. name, { clear = true })
end

-- Files: reload
vim.api.nvim_create_autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup 'checktime',
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd 'checktime'
    end
  end,
})

-- Files: last position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup 'last_loc',
  callback = function(event)
    local exclude = { 'gitcommit' }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].masterjvim_last_loc then
      return
    end
    vim.b[buf].masterjvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


-- Files: create directories
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = augroup 'auto_create_dir',
  callback = function(event)
    if event.match:match '^%w%w+:[\\/][\\/]' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
  end,
})


-- Editing: yank highlight
vim.api.nvim_create_autocmd('TextYankPost', {
  group = augroup 'highlight_yank',
  callback = function()
    if vim.fn.has 'nvim-0.13' == 1 then
      vim.hl.hl_op()
    else
      (vim.hl or vim.highlight).on_yank()
    end
  end,
})

-- Windows: resize
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  group = augroup 'resize_splits',
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd 'tabdo wincmd ='
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Filetypes: close with q
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'close_with_q',
  pattern = {
    'PlenaryTestPopup',
    'checkhealth',
    'dap-float',
    'dbout',
    'gitsigns-blame',
    'grug-far',
    'help',
    'lspinfo',
    'neotest-output',
    'neotest-output-panel',
    'neotest-summary',
    'notify',
    'qf',
    'spectre_panel',
    'startuptime',
    'tsplayground',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set('n', 'q', function()
        vim.cmd 'close'
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = 'Quit buffer',
      })
    end)
  end,
})

-- Filetypes: man buffers
vim.api.nvim_create_autocmd('FileType', {
  group = augroup 'man_unlisted',
  pattern = { 'man' },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})


-- Filetypes: JSON conceal
vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup 'json_conceal',
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Filetypes: comment continuation
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('masterjVim_formatoptions', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove 'o'
  end,
})

-- Terminals: insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  group = augroup('terminal_insert'),
  pattern = 'term://*',
  command = 'startinsert',
})


-- Optional: wrapping and spelling
-- vim.api.nvim_create_autocmd('FileType', {
--   group = augroup 'wrap_spell',
--   pattern = { 'text', 'plaintex', 'typst', 'gitcommit', 'markdown' },
--   callback = function()
--     vim.opt_local.wrap = true
--     vim.opt_local.spell = true
--   end,
-- })

-- Optional: working directory
-- vim.api.nvim_create_autocmd('BufEnter', {
-- group = augroup('auto_chdir'),
-- command = 'silent! lcd %:p:h',
-- })

local prompt_ns = vim.api.nvim_create_namespace('my.terminal.prompt')

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = { '{term,shell}://*', ':shell*' },
  callback = function()
    vim.opt_local.signcolumn = 'auto'

    local opts = { buffer = true, silent = true }
    vim.keymap.set('n', '<CR>', 'i<CR><C-\\><C-n>', opts)
    vim.keymap.set('n', '<C-c>', 'i<C-c><C-\\><C-n>', opts)
  end,
})

vim.api.nvim_create_autocmd('TermRequest', {
  callback = function(ev)
    -- OSC 133: Shell prompt
    if string.match(ev.data.sequence, '^\027]133;A') then
      local lnum = ev.data.cursor[1]
      vim.api.nvim_buf_set_extmark(ev.buf, prompt_ns, lnum - 1, 0, {
        sign_text = '∙',
      })
    end

    -- OSC 7: Directory change
    local val, n = string.gsub(ev.data.sequence, '^\027]7;file://[^/]*', '')
    if n > 0 then
      local dir = val
      assert(vim.fn.isdirectory(dir) ~= 0, 'invalid dir: ' .. dir)

      if vim.api.nvim_get_current_buf() == ev.buf then
        vim.cmd.bcd(dir)
      end
    end
  end,
})
