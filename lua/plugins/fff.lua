-- FFF configuration
vim.g.fff = {
  lazy_sync = true,
  debug = {
    enabled = true,
    show_scores = true,
  },
}

-- Build FFF on install or update
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

vim.pack.add({
  'https://github.com/dmtrKovalenko/fff',
})

-- Keymaps
vim.keymap.set('n', '<C-f>', function()
  require('fff').find_files()
end, { desc = 'Find files' })

vim.filetype.add { extension = { wgsl = "wgsl" } }
vim.keymap.set("n", "gf", function()
  require("fff").open_file_under_cursor(function()
    vim.api.nvim_command "wincmd k"
  end)
end, { silent = true })

vim.keymap.set("n", "<leader>/", function() require('fff').live_grep() end, { desc = 'LiFFFe grep' })

vim.keymap.set('n', 'gf', function()
  require('fff').open_file_under_cursor(function()
    vim.api.nvim_command 'wincmd k'
  end)
end, { silent = true })
