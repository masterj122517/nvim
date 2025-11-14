local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

local function comment_prefix()
  local cs = vim.bo.commentstring or '%s'
  local pre = cs:match '^(.*)%%s'
  return pre and pre:gsub('%s+$', '') or ''
end

local function short_date()
  return os.date '%y-%m-%d'
end

return {
  s(
    'todo',
    fmt(
      [[{} TODO: {} <{}, MasterJ>
{}]],
      {
        f(comment_prefix, {}), -- 注释符，比如 //
        i(1), -- 光标1
        f(short_date, {}), -- 日期
        i(0), -- 下一行是代码行
      }
    )
  ),
}
