return
  {
    "theniceboy/nvim-deus",
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,


    {
      "craftzdog/solarized-osaka.nvim",
      lazy = true,
      priority = 1000,
      opts = function()
        return {
          transparent = true,
        }
      end,
    },
    {
      "catppuccin/nvim",
      name = "catppuccin",
      lazy = true,
      priority = 1000,
    },

    {
      "tjdevries/colorbuddy.nvim",
    },

    {
      "rktjmp/lush.nvim",
      "tckmn/hotdog.vim",
      "dundargoc/fakedonalds.nvim",
      "craftzdog/solarized-osaka.nvim",
      { "rose-pine/neovim", name = "rose-pine" },
      "eldritch-theme/eldritch.nvim",
      "jesseleite/nvim-noirbuddy",
      "vim-scripts/MountainDew.vim",
      "miikanissi/modus-themes.nvim",
      "rebelot/kanagawa.nvim",
      "gremble0/yellowbeans.nvim",
      "rockyzhang24/arctic.nvim",
      "folke/tokyonight.nvim",
      "Shatur/neovim-ayu",
      "RRethy/base16-nvim",
      "xero/miasma.nvim",
      "cocopon/iceberg.vim",
      "kepano/flexoki-neovim",
      "ntk148v/komau.vim",
      { "catppuccin/nvim", name = "catppuccin" },
      "uloco/bluloco.nvim",
      "LuRsT/austere.vim",
      "ricardoraposo/gruvbox-minor.nvim",
      "NTBBloodbath/sweetie.nvim",
      "blazkowolf/gruber-darker.nvim",
      {
        "maxmx03/fluoromachine.nvim",
        -- config = function()
        --   local fm = require "fluoromachine"
        --   fm.setup { glow = true, theme = "fluoromachine" }
        -- end,
      },
    }

  }
