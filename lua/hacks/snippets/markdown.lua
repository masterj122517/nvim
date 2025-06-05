-- 文件位置举例: ~/.config/nvim/lua/snippets/markdown.lua

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    'blog',
    fmt(
      [[
    ---
    title: {}
    date: {}
    tags: [{}]
    ---

    {}
    ]],
      {
        i(1, ''),
        i(2, os.date '%Y-%m-%d'),
        i(3, '标签1, 标签2'),
        i(0),
      }
    )
  ),
}
