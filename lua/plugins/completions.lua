-- Packages
vim.pack.add({
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
  'https://github.com/rafamadriz/friendly-snippets',
})

-- Completion menu
local options = {
  completion = {
    list = {
      selection = { preselect = false, auto_insert = false },
    },
    menu = {
      auto_show = true,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
    ghost_text = {
      enabled = false,
    },
  },

  -- Keymaps
  keymap = {
    -- Enter preset
    preset = 'enter',
    ['<C-Space>'] = false,
    ['<C-o>'] = { 'show', 'fallback' },
    ['<C-y>'] = { 'accept', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'snippet_forward', 'fallback' },
  },

  -- Sources
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },

  -- Command line
  cmdline = {
    keymap = {
      preset = 'cmdline',
      ['<C-Space>'] = false,
      ['<C-o>'] = { 'show', 'fallback' },
      ['<C-y>'] = { 'accept', 'fallback' },

      ['<Tab>'] = { 'show_and_insert', 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'show_and_insert', 'select_prev', 'fallback' },

      ['<Left>'] = false,
      ['<Right>'] = false,
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      menu = {
        auto_show = false, -- 按 Tab 才打开
      },
      ghost_text = {
        enabled = false,
      },
    },
  },
  -- Signature help
  signature = {
    enabled = true,
  },
}

local group = vim.api.nvim_create_augroup('PluginCompletion', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  group = group,
  callback = function()
    vim.api.nvim_clear_autocmds({ group = group })
    require('blink.cmp').setup(options)
  end,
})
