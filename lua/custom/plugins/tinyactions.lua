return {
  "rachartier/tiny-code-action.nvim",
  dependencies = {
    -- optional picker via telescope
    {
      "folke/snacks.nvim",
      opts = {
        terminal = {},
      }
    }
  },
  event = "LspAttach",
  opts = {
    vim.keymap.set({ "n", "x" }, "<leader>ca", function()
      require("tiny-code-action").code_action()
    end, { desc = "Lsp Code Actions", noremap = true, silent = true })
  },
}
