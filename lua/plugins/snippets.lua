return {
	{
		"SirVer/ultisnips",
		dependencies = {
			"honza/vim-snippets",
		},
		config = function()
			vim.g.UltiSnipsSnippetDirectories={"~/.config/nvim/Ultisnips"}
			-- vim.g.UltiSnipsExpandTrigger = ""
            vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
			vim.g.UltiSnipsJumpBackwardTrigger ="<S-tab>"
		end
	},

}
