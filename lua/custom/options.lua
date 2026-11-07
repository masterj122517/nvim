-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- General
vim.g.have_nerd_font = true
vim.g.deprecated_warnings = false
vim.g.python3_host_prog = os.getenv 'PYTHON'
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.o.termguicolors = true

-- UI
vim.o.number = true
vim.o.relativenumber = true
vim.opt.numberwidth = 2
vim.o.signcolumn = 'yes'
vim.o.cursorline = true
vim.o.showmode = false
vim.o.cmdheight = 0
vim.o.pumheight = 10
vim.o.mouse = 'a'
vim.o.scrolloff = 10
vim.o.wrap = false
vim.o.breakindent = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.smoothscroll = true
vim.opt.shortmess = 'filnxtToOScIF'
vim.opt.messagesopt:append({
  "maxheight:30",
  "timeout:5000",
})

local ui = require("vim._core.ui2")

ui.enable({
  enable = true,
  msg = {
    targets = {
      default = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    msg = { height = 0.3 },
    dialog = { height = 0.5 },
    pager = { height = 0.5 },
  },
})

-- Position ephemeral messages at top-right.
local messages = require("vim._core.ui2.messages")
local original_set_pos = messages.set_pos

messages.set_pos = function(target, focus)
  original_set_pos(target, focus)

  if target and target ~= "msg" then
    return
  end

  local win = ui.wins.msg
  if not vim.api.nvim_win_is_valid(win) then
    return
  end

  if vim.api.nvim_win_get_config(win).hide then
    return
  end

  vim.api.nvim_win_set_config(win, {
    relative = "editor",
    anchor = "NE",
    row = 1,
    col = vim.o.columns - 1,
  })
end


-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.formatoptions:remove { 't', 'c', 'o' }

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = 'split'
vim.opt.wildmenu = true
vim.opt.path:append '**'
vim.opt.grepprg = 'rg --vimgrep --no-messages --smart-case'
vim.opt.grepformat = '%f:%l:%c:%m'

-- Editing
vim.o.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.config/nvim/cache/undodir'
vim.o.confirm = true
vim.opt.whichwrap = 'b,s,<,>,h,'
vim.opt.backup = false
vim.opt.swapfile = false

-- Clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Windows
vim.o.splitright = true
vim.o.splitbelow = true

-- Timing
vim.o.updatetime = 300
vim.o.timeoutlen = 300

-- Diagnostics
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
}

-- Completion (disabled)
-- vim.o.autocomplete = true
-- vim.o.complete = 'o,.,w,b,u'
-- vim.opt.completeopt = 'menuone,noselect,fuzzy,popup'
