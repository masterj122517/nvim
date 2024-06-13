return {
    "nvim-treesitter/playground",
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        event = "BufRead", -- 延迟加载，直到打开一个文件
        priority = 1000,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "markdown",
                    "html",
                    "javascript",
                    "typescript",
                    "java",
                    "c",
                    "bash",
                    "go",
                    "lua",
                    "dockerfile",
                    "yaml",
                    "python",
                },
                highlight = {
                    enable = true,
                    disable = {}, -- 禁用某些语言的高亮
                },
                indent = {
                    enable = true -- 启用缩进
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection    = "<c-n>",
                        node_incremental  = "<c-n>",
                        node_decremental  = "<c-h>",
                        scope_incremental = "<c-l>",
                    },
                },
                -- 其他配置可以在此添加
            })
        end
    }
}
