
-- load lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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


require("lazy").setup(
{
    require("plugins.colorscheme"),
    require("plugins.fzf"),
    require("plugins.harpoon"),
    require("plugins.git"),
    require("plugins.fcitx"),
    require("plugins.statusline"),
    require("plugins.indent"),
    require("plugins.treesitter"),
    require("plugins.notify"),
    require("plugins.tabline"),
    require("plugins.scrollbar"),
    require("plugins.undo"),
    require("plugins.snippets"),
    require("plugins.editor"),
    require("plugins.comment").setup(),
    require("plugins.comment").config(),



})
