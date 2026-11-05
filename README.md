This is my minimal config which means no addtional plugins.

but it's still good at least for me. 

Just put this into your ~/.config/nvim and everything is good to go.

## Musubi

Musubi is loaded from the local checkout at `~/programming/kataware.nvim`.
Keep that checkout available; no plugin manager or vendored theme copy is needed.
Theme changes take effect on the next Neovim startup.

The startup configuration preserves the warm-parchment background:

```lua
require('kataware').setup { transparent = false }
vim.cmd.colorscheme 'musubi'
```

Use `:colorscheme kataware` to switch to the dark companion for the current
session. New terminal buffers inherit the active theme's ANSI palette.
