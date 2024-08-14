return {
  "yaocccc/vim-comment",
  config = function()
    -- 设置全局变量 vim.g
    vim.g.vim_line_comments = {
      vim = '"',
      vimrc = '"',
      js = "//",
      ts = "//",
      java = "//",
      class = "//",
      c = "//",
      hpp = "//",
      cpp = "//",
      h = "//",
      go = "//",
      lua = "--",
      proto = "//",
      ["go.mod"] = "//",
      md = "[^_^]:",
      vue = "//",
      sql = "--",
      sol = "//",
    }

    vim.g.vim_chunk_comments = {
      js = { "/**", " *", " */" },
      ts = { "/**", " *", " */" },
      sh = { ":<<!", "", "!" },
      proto = { "/**", " *", " */" },
      md = { "[^_^]:", "    ", "" },
      vue = { "/**", " *", " */" },
      sol = { "/**", " *", " */" },
    }

    -- 设置键映射
    local map = function(mode, lhs, rhs, opts)
      local options = { noremap = true, silent = true }
      if opts then
        options = vim.tbl_extend("force", options, opts)
      end
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end

    map("n", "??", ":NToggleComment<cr>")
    map("v", "/", ":<c-u>VToggleComment<cr>")
    map("v", "?", ":<c-u>CToggleComment<cr>")
  end,
  init = function()
    vim.g.vim_line_comments = {
      vim = '"',
      vimrc = '"',
      js = "//",
      ts = "//",
      java = "//",
      class = "//",
      c = "//",
      hpp = "//",
      cpp = "//",
      h = "//",
      go = "//",
      lua = "--",
      proto = "//",
      ["go.mod"] = "//",
      md = "[^_^]:",
      vue = "//",
      sql = "--",
      sol = "//",
    }

    vim.g.vim_chunk_comments = {
      js = { "/**", " *", " */" },
      ts = { "/**", " *", " */" },
      sh = { ":<<!", "", "!" },
      proto = { "/**", " *", " */" },
      md = { "[^_^]:", "    ", "" },
      vue = { "/**", " *", " */" },
      sol = { "/**", " *", " */" },
    }
  end,
}
