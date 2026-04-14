local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    'main',
    fmt(
      [[
    #include <stdio.h>

    int main(int argc, char *argv[]) {{
        {}
        return 0;
    }}
  ]],
      { i(0) }
    )
  ),

  s('pf', fmt([[printf("{}\n");]], { i(1, 'world') })),
}
