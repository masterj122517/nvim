-- Package
vim.pack.add({
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
})

-- Load before the first client's LspAttach event.
local group = vim.api.nvim_create_augroup('PluginInlineDiagnostic', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile', 'FileType' }, {
	group = group,
	callback = function()
		vim.api.nvim_clear_autocmds({ group = group })
		require("tiny-inline-diagnostic").setup({
			preset = "classic",
			options = {
				use_icons_from_diagnostic = true,
				multilines = {
					enabled = true,
				},
			},
		})
	end,
})
