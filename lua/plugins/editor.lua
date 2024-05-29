vim.cmd([[
fun! s:MakePair()
	let line = getline('.')
	let len = strlen(line)
	if line[len - 1] == ";" || line[len - 1] == ","
		normal! lx$P
	else
		normal! lx$p
	endif
endfun
inoremap <c-u> <ESC>:call <SID>MakePair()<CR>
]])

return {
    {
        "RRethy/vim-illuminate",
        config = function()
            require('illuminate').configure({
                providers = {
                    -- 'lsp',
                    -- 'treesitter',
                    'regex',
                },
            })
            vim.cmd("hi IlluminatedWordText guibg=#393E4D gui=none")
        end
    },
    {
        "dkarter/bullets.vim",
        lazy = false,
        ft = { "markdown", "txt" },
    },
    -- {
    -- 	"psliwka/vim-smoothie",
    -- 	init = function()
    -- 		vim.cmd([[nnoremap <unique> <C-e> <cmd>call smoothie#do("\<C-D>") <CR>]])
    -- 		vim.cmd([[nnoremap <unique> <C-u> <cmd>call smoothie#do("\<C-U>") <CR>]])
    -- 	end
    -- },
    {
        "NvChad/nvim-colorizer.lua",
        opts = {
            filetypes = { "*" },
            user_default_options = {
                RGB = true,           -- #RGB hex codes
                RRGGBB = true,        -- #RRGGBB hex codes
                names = true,         -- "Name" codes like Blue or blue
                RRGGBBAA = false,     -- #RRGGBBAA hex codes
                AARRGGBB = true,      -- 0xAARRGGBB hex codes
                rgb_fn = false,       -- CSS rgb() and rgba() functions
                hsl_fn = false,       -- CSS hsl() and hsla() functions
                css = false,          -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = false,       -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes for `mode`: foreground, background,  virtualtext
                mode = "virtualtext", -- Set the display mode.
                -- Available methods are false / true / "normal" / "lsp" / "both"
                -- True is same as normal
                tailwind = true,
                sass = { enable = false },
                virtualtext = "■",
            },
            -- all the sub-options of filetypes apply to buftypes
            buftypes = {},
        }
    },
    { 'theniceboy/antovim', lazy = false, },
    { 'gcmt/wildfire.vim',  lazy = false, },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end
    },
}
