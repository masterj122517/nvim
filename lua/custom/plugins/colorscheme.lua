return {
  {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('everforest').setup {
        background = 'hard', -- soft, medium, hard
        transparent_background_level = 0,
        dim_inactive = false,
        show_eob = false,
        styles = {
          comments = 'italic',
          functions = 'NONE',
          keywords = 'NONE',
          strings = 'NONE',
          variables = 'NONE',
        },
      }
      -- vim.cmd.colorscheme 'everforest'
    end,
  },
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-moon'
    end,
  },
  -- lua/plugins/rose-pine.lua
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require('rose-pine').setup {
        disable_background = true,
        disable_float_background = true,
        styles = {
          bold = true,
          italic = true,
        },
      }
      vim.cmd 'colorscheme rose-pine'
    end,
  },
  {
    'blazkowolf/gruber-darker.nvim',
    config = function()
      require('gruber-darker').setup {
        'blazkowolf/gruber-darker.nvim',
        opts = {
          bold = false,
          italic = {
            strings = false,
          },
        },
      }
      -- vim.cmd 'colorscheme gruber-darker'
    end,
  },
}
