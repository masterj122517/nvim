vim.pack.add({
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-f>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>sh',builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>uC',builtin.colorscheme, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fb',builtin.current_buffer_fuzzy_find, { desc = 'Telescope help tags' })
vim.keymap.set('n', 'gd'        ,builtin.lsp_definitions, { desc = 'Telescope goto definitions' })
vim.keymap.set('n', 'gr'        ,builtin.lsp_references, { desc = 'Telescope goto reference' })
vim.keymap.set('n', 'gD'        ,builtin.lsp_implementations, { desc = 'Telescope goto implementations' })
vim.keymap.set('n', '<leader>ss',builtin.lsp_workspace_symbols, { desc = 'Telescope search workspace symbols' })
vim.keymap.set('n', '<leader>sS',builtin.lsp_document_symbols, { desc = 'Telescope search document symbols' })

-- lsp 

vim.pack.add {
  { src = 'https://github.com/neovim/nvim-lspconfig' },
}

vim.lsp.config('*', {
  root_markers = { '.git', '.hg' },
})

vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  }
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {},
  },
})



vim.lsp.config('clangd', {
  root_markers = { '.clang-format', 'compile_commands.json' },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        }
      }
    }
  }
})
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('clangd')
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')

vim.keymap.set('i', '<c-f>', vim.lsp.buf.signature_help, { buffer = bufnr, noremap = true, silent = true, desc = 'signature_help' })

-- Workspace management
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, { buffer = bufnr, noremap = true, silent = true, desc = 'Buf Rename' })

vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, noremap = true, silent = true, desc = 'Code Actions' })

--  I guess this is how you setup a easy lsp setup

-- now let's add 

vim.pack.add({
    'https://github.com/stevearc/oil.nvim',
})

require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })



