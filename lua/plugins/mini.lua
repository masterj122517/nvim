-- Packages
vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.ai" },
	{ src = "https://github.com/nvim-mini/mini.align" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/nvim-mini/mini.indentscope" },
	{ src = "https://github.com/nvim-mini/mini.icons" },
	{ src = "https://github.com/nvim-mini/mini.splitjoin" },
	{ src = "https://github.com/nvim-mini/mini.hipatterns" },
})

-- Text objects
local ai = require("mini.ai")
ai.setup({
	-- treesitter textobjects af/if function, ac/ic class
	custom_textobjects = {
		f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
		c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
	},
})

-- Alignment
require("mini.align").setup()

-- Indent guides
local scope_group = vim.api.nvim_create_augroup('PluginIndentScope', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile', 'FileType', 'InsertEnter' }, {
	group = scope_group,
	callback = function()
		vim.api.nvim_clear_autocmds({ group = scope_group })
		require("mini.indentscope").setup({
			symbol = "│",
			draw = {
				animation = require("mini.indentscope").gen_animation.none(),
			},
		})
	end,
})

-- Pairs
vim.api.nvim_create_autocmd('InsertEnter', {
	once = true,
	callback = function()
		require("mini.pairs").setup()
	end,
})

-- Icons
require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- Bracket formatting
require("mini.splitjoin").setup({
	mappings = {
		toggle = "<leader>m",
	},
})

-- Pattern highlights
local pattern_group = vim.api.nvim_create_augroup('PluginHiPatterns', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile', 'FileType', 'InsertEnter' }, {
	group = pattern_group,
	callback = function()
		vim.api.nvim_clear_autocmds({ group = pattern_group })
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				hex_color = hipatterns.gen_highlighter.hex_color(),
				fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
				hack = { pattern = "HACK", group = "MiniHipatternsHack" },
				todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
				note = { pattern = "NOTE", group = "MiniHipatternsNote" },
			},
		})
	end,
})
