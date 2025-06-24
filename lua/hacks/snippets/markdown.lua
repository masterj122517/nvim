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
        i(2, os.date '%y-%m-%d'),
        i(3, '标签1, 标签2'),
        i(0),
      }
    )
  ),

  s(
    'rec',
    fmt(
      [[
Date: {}

Start Feelings: {}

Things to do: {}

While Doing feelings: {}

After feelings: {}

Review: {}
]],
      {
        i(1, os.date '%y-%m-%d'),
        i(2, ''),
        i(3, ''),
        i(4, ''),
        i(5, ''),
        i(6, ''),
      }
    )
  ),
}
