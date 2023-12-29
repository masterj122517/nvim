local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)



-- My Config
--__  __    _    ____ _____ _____ ____     _
--|  \/  |  / \  / ___|_   _| ____|  _ \   | |
--| |\/| | / _ \ \___ \ | | |  _| | |_) |  | |
--| |  | |/ ___ \ ___) || | | |___|  _ < |_| |
--|_|  |_/_/   \_\____/ |_| |_____|_| \_\___/



require("lazy").setup({
    require("plugins.fzf"),
    require("plugins.joshuto"),
    require("plugins.colorscheme"),
    require("plugins.scrollbar"),
    require("plugins.git"),
    require("plugins.statusline"),
    require("plugins.comment"),
    require("plugins.indent"),
    require("plugins.cellular-automation"),
    require("plugins.treesitter"),
    require("plugins.markdown"),
    require("plugins.winbar"),
    require("plugins.snippets"),
    require("plugins.surround"),
    require("plugins.wilder"),
    require("plugins.fcitx"),
    require("plugins.harpoon"),
    require("plugins.undo"),
    require("plugins.tex"),
    require("plugins.editor"),

})
