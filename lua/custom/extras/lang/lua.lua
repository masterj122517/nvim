return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    init = function()
      local group = vim.api.nvim_create_augroup('custom_lua_mappings', { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        pattern = 'lua',
        callback = function(event)
          vim.keymap.set('n', '<leader>x', '<cmd>.lua<CR>', { buffer = event.buf, desc = 'Execute the current line' })
          vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<CR>', { buffer = event.buf, desc = 'Execute the current file' })
          vim.keymap.set('i', '++', ' = <Esc>^yt=f=lpa+ 1', { buffer = event.buf })
          vim.keymap.set('i', '+=', '= <Esc>^yt=f=lpa+', { buffer = event.buf })
        end,
      })
    end,
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              diagnostics = {
                globals = {
                  'vim',
                  'require',
                },
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      },
      filetype_options = {
        lua = {
          tabstop = 2,
          softtabstop = 2,
          shiftwidth = 2,
          expandtab = true,
          formatoptions_remove = 'o',
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },
  },
}
