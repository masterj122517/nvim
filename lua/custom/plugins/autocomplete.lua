local function sidekick_next_edit()
  local sidekick = package.loaded.sidekick
  return sidekick and sidekick.nes_jump_or_apply() or false
end

local function native_inline_completion()
  return vim.lsp.inline_completion.get()
end

return {
  'saghen/blink.cmp',
  version = '1.*',
  event = { 'InsertEnter', 'CmdlineEnter' },
  dependencies = {
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
      config = function()
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
      trigger = { show_in_snippet = false },
      accept = { auto_brackets = { enabled = true } },
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 200,
      },
      menu = {
        draw = { treesitter = { 'lsp' } },
      },
    },
    keymap = {
      preset = 'none',
      ['<C-n>'] = { 'select_next', 'show' },
      ['<C-p>'] = { 'select_prev', 'show' },
      ['<C-y>'] = { 'select_and_accept', 'fallback' },
      ['<C-o>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = {
        'snippet_forward',
        function(cmp)
          if cmp.is_visible() then
            return cmp.select_and_accept()
          end
        end,
        sidekick_next_edit,
        native_inline_completion,
        'fallback',
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        markdown = { inherit_defaults = true, 'dictionary' },
        org = { inherit_defaults = true, 'dictionary' },
        text = { inherit_defaults = true, 'dictionary' },
      },
      providers = {
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
        preset = 'none',
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-y>'] = { 'select_and_accept', 'fallback' },
        ['<C-Space>'] = { 'show', 'fallback' },
      },
    },
  },
}
