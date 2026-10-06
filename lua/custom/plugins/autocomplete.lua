return {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'fang2hou/blink-copilot',
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
      config = function()
        require('luasnip').config.setup {
          history = true,
          delete_check_events = 'TextChanged',
        }
        require('luasnip.loaders.from_vscode').lazy_load()
        require('luasnip.loaders.from_lua').lazy_load {
          paths = { vim.fn.stdpath 'config' .. '/lua/hacks/snippets' },
        }
      end,
    },
    {
      'Kaiser-Yang/blink-cmp-dictionary',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  opts = {
    snippets = { preset = 'luasnip' },
    appearance = { nerd_font_variant = 'mono' },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      menu = {
        draw = {
          treesitter = { 'lsp' },
          columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
        },
      },
      ghost_text = {
        enabled = function()
          local item = require('blink.cmp').get_selected_item()
          return item ~= nil and item.source_id == 'copilot'
        end,
        show_without_selection = false,
        show_without_menu = false,
      },
    },
    keymap = {
      preset = 'enter',
      ['<C-space>'] = false,
      ['<C-o>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-y>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'snippet_forward', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
      per_filetype = {
        markdown = { inherit_defaults = true, 'dictionary' },
        org = { inherit_defaults = true, 'dictionary' },
        text = { inherit_defaults = true, 'dictionary' },
      },
      providers = {
        copilot = {
          name = 'Copilot',
          module = 'blink-copilot',
          async = true,
        },
        dictionary = {
          module = 'blink-cmp-dictionary',
          name = 'Dict',
          min_keyword_length = 3,
          opts = {
            dictionary_files = { '/usr/share/dict/words' },
          },
        },
      },
    },
    cmdline = {
      enabled = true,
      keymap = {
        preset = 'cmdline',
        ['<Right>'] = false,
        ['<Left>'] = false,
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function()
            return vim.fn.getcmdtype() == ':'
          end,
        },
        ghost_text = { enabled = true },
      },
    },
  },
}
