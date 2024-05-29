return {
	{
		"SirVer/ultisnips",
		dependencies = {
			"honza/vim-snippets",
		},
		config = function()
			vim.g.UltiSnipsSnippetDirectories={"~/.config/nvim/Ultisnips"}
            --          vim.g.UltiSnipsExpandTrigger = "<c-o>"
            --          vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
            -- vim.g.UltiSnipsJumpBackwardTrigger ="<S-tab>"
            vim.g.UltiSnipsExpandTrigger="<tab>"
            vim.g.UltiSnipsJumpForwardTrigger="<c-b>"
            vim.g.UltiSnipsJumpBackwardTrigger="<c-z>"

		end
	},

}
