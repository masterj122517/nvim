-- return {
--     -- "rmehri01/onenord.nvim",
--     -- "rebelot/kanagawa.nvim",
--     "rose-pine/neovim",
--     name = "rose-pine",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         --vim.cmd([[hi Normal ctermfg=7 ctermbg=NONE cterm=NONE
--         vim.cmd([[colorscheme rose-pine]])
--     end,
-- }
--
--
return {
    "theniceboy/nvim-deus",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme deus]])
    end,
}
