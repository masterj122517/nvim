return {
  {
    'neanias/everforest-nvim',
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
      require('everforest').setup {
        background = 'hard', -- soft, medium, hard
        transparent_background_level = 1,
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

        transparent = true, -- Enable this to disable setting the background color
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
      -- vim.cmd 'colorscheme rose-pine'
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
  {
    'tjdevries/colorbuddy.nvim',
    priority = 1000,
  },

  {
    dir = vim.fn.stdpath 'config', -- 随便指向一个存在的目录
    priority = 0, -- 确保在主题插件之后启动
    lazy = false, -- 必须立即加载
    config = function()
      -- 庄园的警钟开始鸣响，Sir
      -- start_colorscheme_manager()
      --vim.cmd 'colorscheme rose-pine-main'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,

    config = function()
      require('catppuccin').setup {
        flavour = 'auto', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = true, -- disables setting the background color.
        float = {
          transparent = true, -- enable transparent floating windows
          solid = false, -- use solid styling for floating windows, see |winborder|
        },
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { 'italic' }, -- Change the style of comments
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        auto_integrations = false,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      }

      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
