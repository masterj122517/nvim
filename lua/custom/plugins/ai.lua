return {
  {
    'folke/sidekick.nvim',
    event = 'VeryLazy',
    cmd = 'Sidekick',
    init = function()
      vim.g.ai_cmp = false
    end,
    opts = {
      cli = {
        picker = 'snacks',
        watch = true,
        win = {
          layout = 'right',
        },
        mux = {
          backend = 'tmux',
          enabled = vim.env.TMUX ~= nil,
          create = 'terminal',
        },
        tools = {
          omp = {
            cmd = { 'omp' },
          },
        },
      },
    },
    keys = {
      {
        '<Tab>',
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>' -- fallback to normal tab
          end
        end,
        mode = 'n',
        expr = true,
        desc = 'Go to/apply next edit suggestion',
      },
      {
        '<C-.>',
        function()
          require('sidekick.cli').focus()
        end,
        mode = { 'n', 't', 'i', 'x' },
        desc = 'Focus Sidekick CLI',
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Toggle Sidekick CLI',
      },
      {
        '<leader>ao',
        function()
          require('sidekick.cli').toggle { name = 'omp', focus = true }
        end,
        desc = 'Toggle oh-my-pi',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select { filter = { installed = true } }
        end,
        desc = 'Select installed AI CLI',
      },
      {
        '<leader>ad',
        function()
          require('sidekick.cli').close()
        end,
        desc = 'Detach Sidekick CLI',
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').send { msg = '{this}' }
        end,
        mode = { 'n', 'x' },
        desc = 'Send current object',
      },
      {
        '<leader>af',
        function()
          require('sidekick.cli').send { msg = '{file}' }
        end,
        desc = 'Send file',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send { msg = '{selection}' }
        end,
        mode = 'x',
        desc = 'Send visual selection',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'x' },
        desc = 'Select Sidekick prompt',
      },
      {
        '<leader>uN',
        function()
          local nes = require 'sidekick.nes'
          nes.enable(not nes.enabled)
        end,
        desc = 'Toggle next edit suggestions',
      },
      {
        '<M-]>',
        function()
          vim.lsp.inline_completion.select { count = 1 }
        end,
        mode = { 'i', 'n' },
        desc = 'Next inline suggestion',
      },
      {
        '<M-[>',
        function()
          vim.lsp.inline_completion.select { count = -1 }
        end,
        mode = { 'i', 'n' },
        desc = 'Previous inline suggestion',
      },
    },
  },
  {
    'folke/snacks.nvim',
    optional = true,
    opts = {
      picker = {
        actions = {
          sidekick_send = function(...)
            return require('sidekick.cli.picker.snacks').send(...)
          end,
        },
        win = {
          input = {
            keys = {
              ['<M-a>'] = { 'sidekick_send', mode = { 'n', 'i' } },
            },
          },
        },
      },
    },
  },
}
