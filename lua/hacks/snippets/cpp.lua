local ls = require 'luasnip'
local s = ls.snippet
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
  s(
    { trig = 'st', name = 'Jiangly Template (Clean)', dscr = 'Minimalist CP template with explicit headers' },
    fmt(
      [[
#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <string>

using i64 = long long;

void solve() {{
    {}
}}

int main() {{
    std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);

    int t = 1;
    std::cin >> t;
    while (t--) {{
        solve();
    }}

    return 0;
}}
]],
      {
        i(1, '// GAME START'),
      }
    )
  ),

  -- 2. 现代 C++ 风格的 Lambda DFS 遍历
  s(
    { trig = 'lamdfs', name = 'Lambda DFS', dscr = 'Recursive lambda for tree/graph traversal' },
    fmt(
      [[
auto dfs = [&](auto self, int u, int p) -> void {{
    for (auto v : adj[u]) {{
        if (v == p) continue;
        {}
        self(self, v, u);
    }}
}};
dfs(dfs, {}, -1);
]],
      {
        i(1, '// 深入遍历前的逻辑'),
        i(2, '0'),
      }
    )
  ),
}
