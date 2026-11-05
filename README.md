# Tasteful NeoVim Configuration

## Theme

Musubi is the startup colorscheme. `init.lua` currently enables transparency;
set `transparent = false` there to use the warm-parchment background. Transparent
contrast depends on the host terminal background. `init.lua` loads the local
`~/programming/kataware.nvim` checkout through `runtimepath`; keep it available.
Theme changes take effect on the next Neovim startup without copying files into
this configuration.

Use `:colorscheme kataware` to switch to the dark companion for the current
session. New terminal buffers inherit the active theme's ANSI palette.

## Plugin loading

Packages use native `vim.pack`; no additional plugin manager is required.
On-demand declarations live in `lua/plugins/init.lua` and use a no-op `load`
callback. `load = false` is not equivalent: it adds the package to `runtimepath`,
where startup can still source its plugin scripts.

- `render-markdown.nvim`: first Markdown `FileType`, or `:RenderMarkdown`
  execution/completion. Its plugin entrypoint initializes defaults and attaches
  the current buffer, without replaying `FileType`.
- `tiny-code-action.nvim`: first `<leader>ca` in normal or visual mode.
  The picker is configured once before requesting actions.

Tree-sitter and its FileType activation, LSP/Mason, completion, editing plugins,
Oil, Snacks (including quickfile/bigfile), and Quickfix remain eager. FFF already
defers indexing with `lazy_sync`; Git command implementations are largely
on-demand already. Markdown preview stays eager to preserve its commands and
buffer-local mappings without another loader.
