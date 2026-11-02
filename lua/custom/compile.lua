-- Native compilation: require('custom.compile').build('make').
-- Output is collected until exit; only the latest build updates Quickfix.
-- com saves the current file; <leader>m prompts with the last manual command.
-- C compiles only; Odin/Zig/Python execute exactly the commands listed below.
local M = {}
local generation = 0
local last_command = 'make'

local function build(command)
  generation = generation + 1
  local current = generation
  local cwd = vim.fn.getcwd()
  local efm = vim.api.nvim_get_option_value('errorformat', {})

  local function finish(result)
    if current ~= generation then
      return
    end

    local lines = {}
    for _, output in ipairs({ result.stdout or '', result.stderr or '' }) do
      if output ~= '' then
        local chunk = vim.split(output, '\n', { plain = true })
        if chunk[#chunk] == '' then
          table.remove(chunk)
        end
        vim.list_extend(lines, chunk)
      end
    end

    -- Parse each original line so even ignored/multiline efm patterns cannot
    -- swallow logs or blank lines. The directory entry anchors relative paths
    -- to the build cwd, even if Neovim has since changed directory.
    local items = { { text = '$ ' .. command, valid = 0 } }
    for _, line in ipairs(lines) do
      local parsed = vim.fn.getqflist({
        lines = { '__build_directory__' .. cwd, line },
        efm = '%D__build_directory__%f,' .. efm,
      }).items
      local item = parsed[#parsed] or {}
      item.text = line
      items[#items + 1] = item
    end
    local status = '[Process exited ' .. tostring(result.code)
    if result.signal and result.signal ~= 0 then
      status = status .. ', signal ' .. result.signal
    end
    items[#items + 1] = { text = status .. ']', valid = 0 }
    vim.fn.setqflist({}, 'r', { title = command, items = items })
    vim.cmd('botright copen')
  end

  local argv = { vim.o.shell }
  vim.list_extend(argv, vim.split(vim.o.shellcmdflag, '%s+', { trimempty = true }))
  argv[#argv + 1] = command
  local ok, process = pcall(vim.system, argv, {
    cwd = cwd,
    text = true,
  }, function(result)
    vim.schedule(function()
      finish(result)
    end)
  end)
  if not ok then
    finish({ stderr = tostring(process), code = 'not started' })
    return
  end
  return process
end

-- Buffer-local Odin fallback, outside the generic build function. Existing
-- :compiler / ftplugin errorformat settings take precedence.
local function odin_errorformat(buf)
  if vim.bo[buf].errorformat == '' then
    vim.bo[buf].errorformat = '%f(%l:%c) %t%*[^:]: %m,%f(%l:%c) %m'
  end
end
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('CustomCompile', { clear = true }),
  pattern = 'odin',
  callback = function(event)
    odin_errorformat(event.buf)
  end,
})
-- Set the fallback before ftplugins, including an existing :compiler odin
-- reference whose compiler file may be absent. Later compiler settings win.
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufAdd' }, {
  group = 'CustomCompile',
  pattern = '*.odin',
  callback = function(event)
    odin_errorformat(event.buf)
  end,
})
for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  if vim.bo[buf].filetype == 'odin' then
    odin_errorformat(buf)
  end
end

-- Edit these commands directly; build() has no language-specific behavior.
local function compileRun()
  local ft = vim.bo.filetype
  local file = vim.api.nvim_buf_get_name(0)
  if file == '' then
    return
  end
  vim.cmd('silent update')

  if ft == 'odin' then
    build('odin run .')
  elseif ft == 'c' then
    build('gcc ' .. vim.fn.shellescape(file) .. ' -o '
      .. vim.fn.shellescape(vim.fn.fnamemodify(file, ':r')))
  elseif ft == 'zig' then
    build('zig build run')
  elseif ft == 'python' then
    build('python3 ' .. vim.fn.shellescape(file))
  end
end

local function compile_manual()
  vim.cmd('redraw')
  local ok, command = pcall(vim.fn.input, {
    prompt = 'Compile: ',
    default = last_command,
    completion = 'shellcmd',
    cancelreturn = '',
  })
  if not ok or command == '' then
    return
  end
  last_command = command
  build(command)
end

vim.keymap.set('n', '<leader>m', compile_manual, { desc = 'Compile command' })
-- custom is loaded before plugins; reclaim this key after their setup runs.
vim.schedule(function()
  vim.keymap.set('n', '<leader>m', compile_manual, { desc = 'Compile command' })
end)
vim.keymap.set('n', 'com', compileRun, { desc = 'Compile current file' })
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = 'Next compilation error' })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = 'Previous compilation error' })
vim.keymap.set('n', '<leader>q', '<cmd>copen<CR>', { desc = 'Open quickfix' })

M.build = build
M.run = compileRun
return M
