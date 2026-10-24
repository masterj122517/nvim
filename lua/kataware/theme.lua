local M = {}

function M.load()
  local opts = require('kataware.config').get()
  local colors = require('kataware.colors').setup(opts)
  local groups = require('kataware.groups').setup(colors, opts)

  vim.o.background = 'dark'
  vim.o.termguicolors = true
  vim.cmd.highlight 'clear'
  if vim.fn.exists 'syntax_on' == 1 then
    vim.cmd.syntax 'reset'
  end
  vim.g.colors_name = 'kataware'

  for group, spec in pairs(groups) do
    vim.api.nvim_set_hl(0, group, type(spec) == 'string' and { link = spec } or spec)
  end
  if opts.terminal_colors then
    for index, color in ipairs(colors.terminal) do
      vim.g['terminal_color_' .. (index - 1)] = color
    end
  end

  return colors, groups
end

return M
