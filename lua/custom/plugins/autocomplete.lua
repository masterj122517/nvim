-- 提供 fallback snippet 展开函数
local function expand_snippet(snippet)
  vim.snippet.expand(snippet.body or snippet)
end
-- 可自定义图标表，也可以清空为 {}
local kind_icons = {
  Text = '',
  Method = 'ƒ',
  Function = '',
  Constructor = '',
  Field = '',
  Variable = '',
  Class = '',
  Interface = 'ﰮ',
  Module = '',
  Property = '',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '﬌',
  Color = '',
  File = '',
  Reference = '',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = 'ﬦ',
  TypeParameter = '',
}

-- 你已有的 inside_comment_block 函数不变
local function inside_comment_block()
  if vim.api.nvim_get_mode().mode ~= 'i' then
    return false
  end
  local node = vim.treesitter.get_node()
  local parser = vim.treesitter.get_parser(0, vim.bo.filetype, { error = false })
  local query = parser and vim.treesitter.query.get(vim.bo.filetype, 'highlights')
  if not node or not parser or not query then
    return false
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  for id, n, _ in query:iter_captures(node, 0, row, row + 1) do
    if query.captures[id]:match 'comment' then
      local sr, sc, er, ec = n:range()
      if (sr < row and row < er) or (sr == row and sc <= col) or (er == row and col <= ec) then
        return true
      end
    end
  end

  return false
end

return {
  'saghen/blink.cmp',
  version = '*',
  build = vim.g.lazyvim_blink_main and 'cargo build --release',
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'saghen/blink.compat',
      optional = true,
      opts = {},
      version = '*',
    },
    {
      'Kaiser-Yang/blink-cmp-dictionary',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  event = 'InsertEnter',
  opts = {
    snippets = {
      expand = expand_snippet,
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    completion = {
      accept = {
        auto_brackets = { enabled = true },
      },
      menu = {
        draw = {
          treesitter = { 'lsp' },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },

    sources = {
      default = function()
        local ft = vim.bo.filetype
        local res = { 'lsp', 'path', 'snippets', 'buffer' }
        if vim.tbl_contains({ 'markdown', 'text', 'org' }, ft) or ft == '' or inside_comment_block() then
          table.insert(res, 'dictionary')
        end
        return res
      end,
      providers = {
        dictionary = {
          module = 'blink-cmp-dictionary',
          name = 'Dict',
          kind = 'Dictionary',
          min_keyword_length = 3,
          opts = {
            dictionary_files = {
              '/usr/share/dict/words',
            },
          },
        },
      },
    },

    cmdline = {
      enabled = false,
    },

    keymap = {
      preset = 'enter',
      ['<C-y>'] = { 'select_and_accept' },
      ['<C-o>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        'snippet_forward',
        'fallback',
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },
  },

  config = function(_, opts)
    local enabled = opts.sources.default
    for _, source in ipairs(opts.sources.compat or {}) do
      opts.sources.providers[source] = vim.tbl_deep_extend('force', { name = source, module = 'blink.compat.source' }, opts.sources.providers[source] or {})
      if type(enabled) == 'table' and not vim.tbl_contains(enabled, source) then
        table.insert(enabled, source)
      end
    end

    opts.sources.compat = nil

    for _, provider in pairs(opts.sources.providers or {}) do
      if provider.kind then
        local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
        local kind_idx = #CompletionItemKind + 1

        CompletionItemKind[kind_idx] = provider.kind
        CompletionItemKind[provider.kind] = kind_idx

        local transform_items = provider.transform_items
        provider.transform_items = function(ctx, items)
          items = transform_items and transform_items(ctx, items) or items
          for _, item in ipairs(items) do
            item.kind = kind_idx or item.kind
            item.kind_icon = kind_icons[item.kind_name] or item.kind_icon or nil
          end
          return items
        end

        provider.kind = nil
      end
    end

    require('blink.cmp').setup(opts)
  end,
}
