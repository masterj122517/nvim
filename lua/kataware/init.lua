local M = {}

---@param opts? kataware.Config
function M.setup(opts)
  require('kataware.config').setup(opts)
end

function M.load()
  return require('kataware.theme').load()
end

return M
