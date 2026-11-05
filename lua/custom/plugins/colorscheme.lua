return {
  {
    dir = vim.fn.expand '~/programming/kataware.nvim',
    name = 'kataware',
    lazy = false,
    priority = 1000,
    config = function()
      require('kataware').setup {
        transparent = false,
        on_highlights = function(groups)
          -- Preserve this branch's LuaLS/Tree-sitter highlighting preferences.
          groups['@lsp.type.variable.lua'] = {}
          groups['@lsp.type.property.lua'] = {}
          groups['@lsp.typemod.function.defaultLibrary.lua'] = '@function.builtin.lua'
        end,
      }
      vim.cmd.colorscheme 'musubi'
    end,
  },
}
