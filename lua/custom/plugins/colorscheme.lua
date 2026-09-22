return {
  {
    dir = vim.fn.stdpath 'config',
    name = 'kataware',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.kataware_transparent = true
      vim.cmd.colorscheme 'kataware'
    end,
  },
}
