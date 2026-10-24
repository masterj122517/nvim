This is my minimal config which means no addtional plugins.

but it's still good at least for me. 

Just put this into your ~/.config/nvim and everything is good to go.

## Kataware

Kataware is vendored in `colors/kataware.lua` and `lua/kataware/`; updating the
theme requires both paths. No theme plugin download is required.

The palette remains Kataware's indigo/spectral scheme. Ordinary and relative
line numbers use muted blue-gray; the current line number is bold gold.
Optional settings go before `colorscheme kataware`:

```lua
require('kataware').setup { transparent = true }
vim.cmd.colorscheme 'kataware'
```

Without an explicit setup option, `vim.g.kataware_transparent` still controls
transparency and is read on each colorscheme reload.
