return
  {
    "theniceboy/nvim-deus",
    "scottmckendry/cyberdream.nvim",
    lazy = true,
    priority = 1000,


    {
      "craftzdog/solarized-osaka.nvim",
      laz = true,
      priority = 1000,
      opts = function()
        return {
          transparent = true,
        }


      end,
    }

  }
