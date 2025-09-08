return {
  {
    'michaelb/sniprun',
    branch = 'master',

    build = 'sh install.sh',
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

    config = function()
      require('sniprun').setup {
        live_mode_toggle = 'disable',
        vim.keymap.set('v', '<leader>mr', ':SnipRun<CR>', { silent = true }),
        vim.keymap.set('n', '<leader>mr', ':SnipRun<CR>', { silent = true }),
        vim.keymap.set('n', '<leader>mc', ':SnipClose<CR>', { silent = true }),
        display = {
          --'Classic', --# display results in the command-line  area
          --'VirtualTextOk', --# display ok results as virtual text (multiline is shortened)

          -- "VirtualText",             --# display results as virtual text
          -- "VirtualLine",             --# display results as virtual lines
          -- "TempFloatingWindow",      --# display results in a floating window
          -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
          'Terminal', --# display results in a vertical split
          --'TerminalWithCode', --# display results and code history in a vertical split
          -- "NvimNotify",              --# display with the nvim-notify plugin
          -- "Api"                      --# return output to a programming interface
        },

        -- live_display = { 'VirtualTextOk' }, --# display mode used in live_mode
        live_display = { 'VirtualTextOk' }, --# display mode used in live_mode

        display_options = {
          terminal_scrollback = vim.o.scrollback, --# change terminal display scrollback lines
          terminal_line_number = false, --# whether show line number in terminal window
          terminal_signcolumn = false, --# whether show signcolumn in terminal window
          terminal_position = 'vertical', --# or "horizontal", to open as horizontal split instead of vertical split
          terminal_width = 45, --# change the terminal display option width (if vertical)
          terminal_height = 20, --# change the terminal display option height (if horizontal)
          notification_timeout = 5, --# timeout for nvim_notify output
        },
      }
    end,
  },
}
