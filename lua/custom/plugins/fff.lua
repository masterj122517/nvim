return {
  'dmtrKovalenko/fff',
  build = function()
    -- downloads a prebuilt binary or falls back to cargo build
    require('fff.download').download_or_build_binary()
  end,
  -- for nixos:
  -- build = "nix run .#release",
  opts = {
    debug = {
      enabled = true,
      show_scores = true,
    },
  },
  lazy = false, -- the plugin lazy-initialises itself
  keys = {
    {
      '<C-f>',
      function()
        require('fff').find_files()
      end,
      desc = 'FFFind files',
    },
    {
      '<Leader>/',
      function()
        require('fff').live_grep()
      end,
      desc = 'LiFFFe grep',
    },
    {
      '<Leader>sg',
      function()
        require('fff').live_grep { grep = { modes = { 'fuzzy', 'plain' } } }
      end,
      desc = 'Live fffuzy grep',
    },
    {
      '<Leader>sw',
      function()
        require('fff').live_grep_under_cursor()
      end,
      mode = { 'n', 'x' },
      desc = 'Search current word / selection',
    },

    --     {
    --       'gf',
    --       function()
    --         require('fff').open_file_under_cursor(function()
    --           vim.api.nvim_command 'wincmd k'
    --         end)
    --       end,
    --       mode = { 'n', 'x' },
    --       desc = 'Open file under Curosr',
    --     },
  },
}
