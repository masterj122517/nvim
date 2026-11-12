-- Deferred packages
vim.pack.add({
  'https://github.com/rachartier/tiny-code-action.nvim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
}, {
  load = function() end,
})

-- Plugin setup
require("plugins.oil")
require("plugins.fff")
require("plugins.completions")
require("plugins.lualine")
require("plugins.surround")
require("plugins.which_key")
require("plugins.diagnostic")
require("plugins.notice")
require("plugins.mini")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.format")
require("plugins.quickfix")
require("plugins.fidget")
require("plugins.git")
require("plugins.markdown")
require("plugins.snacks")
require("plugins.present")
require("plugins.smart_column")
require("plugins.ai")
