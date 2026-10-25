-- Package name changed from `fff.nvim` to `fff`. If you installed fff.nvim before, clean with `:packdel fff.nvim`
vim.pack.add({ 
  'https://github.com/dmtrKovalenko/fff',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/neovim/nvim-lspconfig',
  "https://github.com/mason-org/mason.nvim",
})

-- Package name changed from `fff.nvim` to `fff`. If you installed fff.nvim before, clean with `:packdel fff.nvim`

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then vim.cmd.packadd('fff') end
      require('fff.download').download_or_build_binary()
    end
  end,
})

vim.g.fff = {
  lazy_sync = true,
  debug = { enabled = true, show_scores = true },
}

vim.keymap.set('n', '<C-f>', function() require('fff').find_files() end, { desc = 'FFFind files' })
vim.keymap.set('n', '<Leader>/', function() require('fff').live_grep() end, { desc = 'LiFFFe grep' })

require("oil").setup()

require("mason").setup()

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			if client.name == "ols" then
				local chars = client.server_capabilities.completionProvider.triggerCharacters or {}
				local seen = {}

				for _, char in ipairs(chars) do
					seen[char] = true
				end

				for char in ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_"):gmatch(".") do
					if not seen[char] then
						table.insert(chars, char)
						seen[char] = true
					end
				end

				client.server_capabilities.completionProvider.triggerCharacters = chars
			end

			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})
vim.opt.autocomplete = true
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.keymap.set("i", "<C-o>", function()
	vim.lsp.completion.get()
end, { desc = "Trigger LSP completion" })
vim.keymap.set("i", "<CR>", function()
	return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true, desc = "Accept completion or insert newline" })


vim.lsp.enable({
  "lua_ls", 
  "rust_analyzer", "clangd", "ruff",
  "ols", 
  "zls", "pyright"
})



