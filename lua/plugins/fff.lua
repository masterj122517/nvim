-- File search options
vim.g.fff = {
  lazy_sync = true,
  debug = {
    enabled = true,
    show_scores = true,
  },
}

-- Installation hook
vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('masterjVim_fff', { clear = true }),
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind

    if name == 'fff' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then
        vim.cmd.packadd('fff')
      end

      require('fff.download').download_or_build_binary()
    end
  end,
})

-- Package
vim.pack.add({
  'https://github.com/dmtrKovalenko/fff',
})

-- Search keymaps
vim.keymap.set('n', '<C-f>', function()
  require('fff').find_files()
end, { desc = 'Find files' })

vim.keymap.set("n", "gf", function()
  require("fff").open_file_under_cursor(function()
    vim.api.nvim_command "wincmd k"
  end)
end, { silent = true })

vim.keymap.set("n", "<leader>/", function() require('fff').live_grep() end, { desc = 'LiFFFe grep' })
