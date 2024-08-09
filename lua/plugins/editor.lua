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

}
