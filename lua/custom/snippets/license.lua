local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node

-- 创建一个动态节点来插入当前年份
local function date_input()
  return sn(nil, {
    t({ os.date("%Y") }),
  })
end

ls.add_snippets("all", {
  s("mit", {
    t({ "MIT License", "", "Copyright (c) " }),
    d(1, date_input), -- 使用动态节点插入当前年份
    t({ " ", "" }),
    i(2, "Author Name"),
    t({
      "",
      "",
      [[Permission is hereby granted, free of charge, to any person obtaining a copy]],
      [[of this software and associated documentation files (the "Software"), to deal]],
      [[in the Software without restriction, including without limitation the rights]],
      [[to use, copy, modify, merge, publish, distribute, sublicense, and/or sell]],
      [[copies of the Software, and to permit persons to whom the Software is]],
      [[furnished to do so, subject to the following conditions:]],
      [[ ]],
      [[The above copyright notice and this permission notice shall be included in all]],
      [[copies or substantial portions of the Software.]],
      [[ ]],
      [[THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR]],
      [[IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,]],
      [[FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE]],
      [[AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER]],
      [[LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,]],
      [[OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE]],
      [[SOFTWARE.]],
    }),
  }),
})
