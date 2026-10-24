local M = {}

function M.setup(colors, opts)
  local groups = {}
  for _, module in ipairs { 'base', 'syntax', 'plugins' } do
    groups = vim.tbl_extend('force', groups, require('kataware.groups.' .. module).get(colors))
  end
  if opts.on_highlights then
    opts.on_highlights(groups, colors)
  end
  return groups
end

return M
