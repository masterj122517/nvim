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

local lazy_cmd = require("lazy.view.config").commands
local lazy_keys = {
    { cmd = "install", key = "i" },
    { cmd = "update",  key = "u" },
    { cmd = "sync",    key = "s" },
    { cmd = "clean",   key = "cl" },
    { cmd = "check",   key = "ch" },
    { cmd = "log",     key = "l" },
    { cmd = "restore", key = "rs" },
    { cmd = "profile", key = "p" },
    { cmd = "profile", key = "p" },
}
for _, v in ipairs(lazy_keys) do
    lazy_cmd[v.cmd].key = "<SPC>" .. v.key
    lazy_cmd[v.cmd].key_plugin = "<leader>" .. v.key
end
vim.keymap.set("n", "<leader>pl", ":Lazy<CR>", { noremap = true })



-- My Config
--__  __    _    ____ _____ _____ ____     _
--|  \/  |  / \  / ___|_   _| ____|  _ \   | |
--| |\/| | / _ \ \___ \ | | |  _| | |_) |  | |
--| |  | |/ ___ \ ___) || | | |___|  _ < |_| |
--|_|  |_/_/   \_\____/ |_| |_____|_| \_\___/



require("lazy").setup({

    require("plugins.colorscheme"),
    require("plugins.fzf"),
    require("plugins.scrollbar"),
    require("plugins.git"),
    require("plugins.statusline"),
    require("plugins.indent"),
    require("plugins.cellular-automation"),
    require("plugins.treesitter"),
    require("plugins.markdown"),
    require("plugins.winbar"),
    require("plugins.joshuto"),
    require("plugins.snippets"),
    require("plugins.surround"),
    require("plugins.wilder"),
    require("plugins.fcitx"),
    require("plugins.harpoon"),
    require("plugins.undo"),
    require("plugins.tex"),
    require("plugins.editor"),
    require("plugins.yank"),
    require("plugins.debugger"),
    require("plugins.autocomplete").config,
    require("plugins.lspconfig").config,
    require("plugins.telescope").config,
    require("plugins.go"),
    require("plugins.multi-cursor"),
    --
    require("plugins.comment").setup(),
    require("plugins.comment").config(),

}, {
})


require("utils.compile_run")
