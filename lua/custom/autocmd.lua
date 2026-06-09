vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.hl_op()
  end,
})

-- auto cd to Buf's path
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    -- 跳过特殊 buffer
    local buftype = vim.bo.buftype
    local filetype = vim.bo.filetype
    local skip_ft = { NvimTree = true, TelescopePrompt = true, help = true, qf = true }
    local skip_bt = { nofile = true, terminal = true, prompt = true }

    if skip_bt[buftype] or skip_ft[filetype] then
      return
    end

    local filepath = vim.api.nvim_buf_get_name(0)
    if filepath == '' then
      return
    end -- 跳过 unnamed buffer

    local dir = vim.fn.fnamemodify(filepath, ':p:h')
    if vim.fn.isdirectory(dir) == 1 then
      vim.cmd('lcd ' .. vim.fn.fnameescape(dir))
    end
  end,
})
