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
            vim.g.UltiSnipsJumpForwardTrigger="<c-j>"
            vim.g.UltiSnipsJumpBackwardTrigger="<c-k>"

		end
	},

}
