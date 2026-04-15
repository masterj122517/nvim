return {
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      max_file_length = 10000,
      signs = {
        add = { text = '┃' }, -- 或者 '▎'、'│'、'▍'
        change = { text = '▎' }, -- 或者 '┃'、'│'、'▍'
        delete = { text = '󰍴' }, -- 或者 ''、'🗑'、'━'
        topdelete = { text = '‾' }, -- 或者 ''
        changedelete = { text = '▍' }, -- 或者 '▌'
      },
    },
  },
  {
    'NeogitOrg/neogit',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim', -- required

      -- Only one of these is needed.
      'sindrets/diffview.nvim', -- optional
      'esmuellert/codediff.nvim', -- optional

      -- Only one of these is needed.
      'nvim-telescope/telescope.nvim', -- optional
      'ibhagwan/fzf-lua', -- optional
      'nvim-mini/mini.pick', -- optional
      'folke/snacks.nvim', -- optional
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
    },
  },
}
