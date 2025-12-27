local function start_colorscheme_manager()
  local themes = { 'everforest', 'tokyonight', 'rose-pine-main', 'gruber-darker', 'colorbuddy', 'gruvbuddy' }
  math.randomseed(os.time())
  local current_index = math.random(#themes)
  local uv = vim.loop or vim.uv
  local timer = uv.new_timer()
  local interval = 1 * 60 * 60 * 1000

  timer:start(
    0,
    interval,
    vim.schedule_wrap(function()
      local theme = themes[current_index]
      -- 注意：此处拼写已修正为 colorscheme
      pcall(vim.cmd.colorscheme, theme)
      current_index = current_index % #themes + 1
    end)
  )
end

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
      start_colorscheme_manager()
    end,
  },
}
