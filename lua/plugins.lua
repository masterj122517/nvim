-- My Config
--__  __    _    ____ _____ _____ ____     _
--|  \/  |  / \  / ___|_   _| ____|  _ \   | |
--| |\/| | / _ \ \___ \ | | |  _| | |_) |  | |
--| |  | |/ ___ \ ___) || | | |___|  _ < |_| |
--|_|  |_/_/   \_\____/ |_| |_____|_| \_\___/


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--local lazy_cmd = require("lazy.view.config").commands
--local lazy_keys = {
--    { cmd = "install", key = "i" },
--    { cmd = "update",  key = "u" },
--    { cmd = "sync",    key = "s" },
--    { cmd = "clean",   key = "cl" },
--    { cmd = "check",   key = "ch" },
--    { cmd = "log",     key = "l" },
--    { cmd = "restore", key = "rs" },
--    { cmd = "profile", key = "p" },
--    { cmd = "profile", key = "p" },
--}
--for _, v in ipairs(lazy_keys) do
--    lazy_cmd[v.cmd].key = "<SPC>" .. v.key
--    lazy_cmd[v.cmd].key_plugin = "<leader>" .. v.key
--end
vim.keymap.set("n", "<leader>pl", ":Lazy<CR>", { noremap = true })




require("lazy").setup({
    require("plugins.colorscheme"),
    require("plugins.startuptime"),
    require("plugins.markdown"),
    require("plugins.telescope"),
    require("plugins.editor"),
    require("plugins.fzf"),
    require("plugins.hlchunk"),
    require("plugins.statusline"),
    require("plugins.treesitter"),
    require("plugins.fcitx"),


}, {
})

require("plugins.md-snippets") 
require("plugins.compile_run") 

