vim.pack.add({
  "https://github.com/olimorris/codecompanion.nvim",
  "nvim-lua/plenary.nvim",
})

require("codecompanion").setup({
  opts = {
    log_level = "DEBUG", -- or "TRACE"
  }
})
