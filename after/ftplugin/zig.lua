local function should_pair_pipe()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor[1], cursor[2]

  local lines = vim.api.nvim_buf_get_lines(
    0,
    math.max(0, row - 9),
    row,
    false
  )

  -- Only inspect text before the cursor.
  lines[#lines] = lines[#lines]:sub(1, col)

  local context = table.concat(lines, '\n')
  context = context:gsub('%s+$', '')

  -- if (condition) |value|
  -- while (condition) |value|
  -- for (items) |item|
  local control_capture =
      context:match('%f[%w_]if%s*%b()%s*$')
      or context:match('%f[%w_]while%s*%b()%s*$')
      or context:match('%f[%w_]for%s*%b()%s*$')

  -- expression catch |err|
  local error_capture =
      context:match('%f[%w_]catch%s*$')

  -- switch prong capture => |value|
  local switch_capture =
      context:match('=>%s*$')

  return control_capture or error_capture or switch_capture
end

vim.keymap.set('i', '|', function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = vim.api.nvim_get_current_line()
  local next_char = line:sub(cursor[2] + 1, cursor[2] + 1)

  -- Skip an existing closing pipe.
  if next_char == '|' then
    return '<Right>'
  end

  -- Only pair pipes in Zig capture contexts.
  if should_pair_pipe() then
    return '||<Left>'
  end

  return '|'
end, {
  buffer = true,
  expr = true,
  replace_keycodes = true,
  desc = 'Zig: smart pipe pairing',
})
