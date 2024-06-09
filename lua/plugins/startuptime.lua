return 
{
    "dstein64/vim-startuptime",
    config = function() 
        vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>StartupTime<CR>', { noremap = true, silent = true })
    end,
}
