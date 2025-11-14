return {
  'ej-shafran/compile-mode.nvim',
  version = '^5.0.0',
  -- you can just use the latest version:
  -- branch = "latest",
  -- or the most up-to-date updates:
  -- branch = "nightly",
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    -- { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    vim.keymap.set('n', '<LEADER>mm', ':Compile<CR>', { desc = 'Run Compile Mode' })
    vim.keymap.set('n', '<LEADER>mM', ':Recompile<CR>', { desc = 'Run Recompile Mode' })
    ---@type CompileModeOpts
    vim.g.compile_mode = {
      input_word_completion = true,
      -- to add ANSI escape code support, add:
      -- baleia_setup = true,

      -- to make `:Compile` replace special characters (e.g. `%`) in
      -- the command (and behave more like `:!`), add:
      -- bang_expansion = true,
    }
  end,
}
