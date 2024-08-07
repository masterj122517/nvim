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
    "yaocccc/vim-surround",
  },
}
