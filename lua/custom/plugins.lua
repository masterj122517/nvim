vim.pack.add({
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-f>", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>,", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>uC", builtin.colorscheme, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "Telescope help tags" })
vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Telescope goto definitions" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Telescope goto reference" })
vim.keymap.set("n", "gD", builtin.lsp_implementations, { desc = "Telescope goto implementations" })
vim.keymap.set("n", "<leader>ss", builtin.lsp_workspace_symbols, { desc = "Telescope search workspace symbols" })
vim.keymap.set("n", "<leader>sS", builtin.lsp_document_symbols, { desc = "Telescope search document symbols" })

-- lsp

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
})

vim.lsp.config("*", {
	root_markers = { ".git", ".hg" },
})

vim.lsp.config("*", {
	capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	},
})

vim.lsp.config("rust_analyzer", {
	settings = {
		["rust-analyzer"] = {},
	},
})

vim.lsp.config("clangd", {
	root_markers = { ".clang-format", "compile_commands.json" },
	capabilities = {
		textDocument = {
			completion = {
				completionItem = {
					snippetSupport = true,
				},
			},
		},
	},
})
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")

vim.lsp.enable("fennel_ls")

vim.keymap.set(
	"i",
	"<c-f>",
	vim.lsp.buf.signature_help,
	{ buffer = bufnr, noremap = true, silent = true, desc = "signature_help" }
)

-- Workspace management
vim.keymap.set(
	"n",
	"<leader>cr",
	vim.lsp.buf.rename,
	{ buffer = bufnr, noremap = true, silent = true, desc = "Buf Rename" }
)

vim.keymap.set(
	"n",
	"<leader>ca",
	vim.lsp.buf.code_action,
	{ buffer = bufnr, noremap = true, silent = true, desc = "Code Actions" }
)

--  I guess this is how you setup a easy lsp setup

-- now let's add

vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
})

require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- markdown preview is a big thing for me.

vim.pack.add({
	"https://github.com/selimacerbas/live-server.nvim",
	"https://github.com/selimacerbas/markdown-preview.nvim",
})

require("markdown_preview").setup({
	instance_mode = "takeover",
	open_browser = true,
	default_theme = "dark",
	debounce_ms = 300,
})

vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

require("mini.ai").setup({ n_lines = 500 })

local statusline = require("mini.statusline")
-- set use_icons to true if you have a Nerd Font
statusline.setup({ use_icons = vim.g.have_nerd_font })

require("mini.icons").setup({})

require("mini.tabline").setup({ show_icons = true, format = nil, tabpage_section = "left" })
require("mini.pairs").setup()

vim.pack.add({
	{
		src = "https://github.com/kylechui/nvim-surround",
		version = vim.version.range("4.x"), -- Use for stability; omit to use `main` branch for the latest features
	},
})
vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		-- Conform will run multiple formatters sequentially
		python = { "isort", "black" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
	},
	format_on_save = function(bufnr)
		if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			return
		end
		-- 超过 1000 行跳过
		if vim.api.nvim_buf_line_count(bufnr) > 1000 then
			return
		end
		local disable_filetypes = { markdown = true }
		if disable_filetypes[vim.bo[bufnr].filetype] then
			return nil
		else
			return {
				timeout_ms = 3000,
				lsp_format = "fallback",
			}
		end
	end,
	formatters_by_ft = {
		lua = { "stylua" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		go = { "goimports" },
		rust = { "rustfmt" },
		python = { "black" },
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/completion") then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}
			for i = 32, 126 do
				table.insert(chars, string.char(i))
			end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

vim.cmd([[set completeopt+=menuone,noselect,popup]])

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"fennel",
		"svelte",
		"markdown",
		"lua",
		"rust",
		"typst",
		"typescript",
		"javascript",
		"c",
		"cpp",
		"glsl",
		"zig",
		"python",
		"typescriptreact",
		"react",
	},
	callback = function()
		vim.treesitter.start()
	end,
})

vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
})

require("mason").setup()

vim.pack.add({
	"https://github.com/supermaven-inc/supermaven-nvim",
})

require("supermaven-nvim").setup({})
