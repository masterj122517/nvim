local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- attributes
  s('derivedebug', t '#[derive(Debug)]'),
  s('deadcode', t '#[allow(dead_code)]'),
  s('allowfreedom', t '#![allow(clippy::disallowed_names, unused_variables, dead_code)]'),
  s('clippypedantic', t '#![warn(clippy::all, clippy::pedantic)]'),

  -- turbofish ::<>
  s('turbofish', {
    t '::<',
    i(1),
    t '>',
  }),

  -- println!("{:?}", x)
  s('print', {
    t 'println!("',
    i(1, '{:?}'),
    t '", ',
    i(0),
    t ');',
  }),

  -- for x in y {}
  s('for', {
    t 'for ',
    i(1, 'x'),
    t ' in ',
    i(2, 'iter'),
    t { ' {', '\t' },
    i(0),
    t { '', '}' },
  }),

  -- struct
  s('struct', {
    t { '#[derive(Debug)]', 'struct ' },
    i(1, 'Name'),
    t { ' {', '\t' },
    i(0),
    t { '', '}' },
  }),

  -- #[test]
  s('test', {
    t { '#[test]', 'fn ' },
    i(1, 'test_name'),
    t { '() {', '\t' },
    t 'assert!(',
    i(0),
    t ');',
    t { '', '}' },
  }),

  -- cfg(test) mod tests
  s('testcfg', {
    t { '#[cfg(test)]', 'mod ' },
    i(1, 'tests'),
    t { ' {', '\t#[test]', '\tfn ' },
    i(2, 'test_name'),
    t { '() {', '\t\tassert!(' },
    i(0),
    t { ');', '\t}', '}' },
  }),

  -- if
  s('if', {
    t 'if ',
    i(1, 'cond'),
    t { ' {', '\t' },
    i(0),
    t { '', '}' },
  }),
}
