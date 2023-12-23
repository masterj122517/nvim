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
})

