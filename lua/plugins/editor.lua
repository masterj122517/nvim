return {
  {
    "folke/flash.nvim",
    enabled = false,
  },

  {
    "yaocccc/vim-fcitx2en",
    event = "InsertLeavePre",
  },

  -- -- animations
  -- {
  --   "echasnovski/mini.animate",
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     opts.scroll = {
  --       enable = false,
  --     }
  --   end,
  -- },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
          ███╗   ███╗ █████╗ ███████╗████████╗███████╗██████╗      ██╗
          ████╗ ████║██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗     ██║
          ██╔████╔██║███████║███████╗   ██║   █████╗  ██████╔╝     ██║
          ██║╚██╔╝██║██╔══██║╚════██║   ██║   ██╔══╝  ██╔══██╗██   ██║
          ██║ ╚═╝ ██║██║  ██║███████║   ██║   ███████╗██║  ██║╚█████╔╝
          ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝ ╚════╝ 
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  {
    "lambdalisue/vim-suda",
    event = "VeryLazy",
  },

  {
    "nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end,
  },

  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "OpenParent directory"})
  },
}
