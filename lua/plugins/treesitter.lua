-- Plugins
vim.pack.add({
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/SUSTech-data/wildfire.nvim',
})

local treesitter = require('nvim-treesitter')

-- Disable LSP semantic highlighting
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('masterjVim_lsp_highlight', {
    clear = true,
  }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Enable Tree-sitter highlighting
local function start_treesitter(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end

  local ok = pcall(vim.treesitter.start, buf)

  if ok then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end

  return ok
end

-- Install missing parsers
local installing = {}
local failed = {}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('masterjVim_treesitter', {
    clear = true,
  }),

  callback = function(event)
    local buf = event.buf
    local ft = vim.bo[buf].filetype

    if ft == '' then
      return
    end

    -- Use installed parser
    if start_treesitter(buf) then
      return
    end

    local lang = vim.treesitter.language.get_lang(ft) or ft

    -- Skip unsupported languages
    if not vim.tbl_contains(treesitter.get_available(), lang) then
      return
    end

    if installing[lang] or failed[lang] then
      return
    end

    installing[lang] = true

    -- Install parser
    vim.schedule(function()
      local ok = pcall(function()
        treesitter.install({ lang }):wait(300000)
      end)

      installing[lang] = nil

      if not ok then
        failed[lang] = true
        vim.notify('Tree-sitter install failed: ' .. lang, vim.log.levels.WARN)
        return
      end

      -- Enable highlighting in matching buffers
      for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(b) then
          local bft = vim.bo[b].filetype
          local blang = vim.treesitter.language.get_lang(bft) or bft

          if blang == lang then
            start_treesitter(b)
          end
        end
      end
    end)
  end,
})

-- Wildfire
require('wildfire').setup()
