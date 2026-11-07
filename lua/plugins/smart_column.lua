vim.pack.add({
  "https://github.com/m4xshen/smartcolumn.nvim",
})
require("smartcolumn").setup(
  {
    colorcolumn = "100",
    disabled_filetypes = { "NvimTree", "lazy", "mason", "help", "checkhealth", "lspinfo", "noice", "Trouble", "fish", "zsh" }
  })
