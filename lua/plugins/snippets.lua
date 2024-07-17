return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
  dependencies = { "rafamadriz/friendly-snippets" },

  require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/custom/snippets" }),
}
