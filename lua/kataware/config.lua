local M = {}

---@class kataware.Config
---@field transparent? boolean Remove editor and floating-window backgrounds.
---@field terminal_colors? boolean Set Neovim's terminal palette.
---@field on_colors? fun(colors: table) Customize the palette before building highlights.
---@field on_highlights? fun(highlights: table, colors: table) Customize final highlights.

local options = {}

---@param opts? kataware.Config
function M.setup(opts)
  options = vim.deepcopy(opts or {})
end

---@return kataware.Config
function M.get()
  local resolved = vim.tbl_deep_extend('force', { terminal_colors = true }, options)
  -- The global remains a first-class input, read on every colorscheme reload.
  if resolved.transparent == nil then
    resolved.transparent = vim.g.kataware_transparent == true
  end
  return resolved
end

return M
