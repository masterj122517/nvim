# Neovim config summary (full)

This summary lists all configuration points and flags possible performance slowdowns.

## init and plugin manager
- init.lua: loads custom options, keymaps, and autocmds; bootstraps lazy.nvim; loads all plugins from custom.plugins; configures lazy UI icons.

## core options (custom/options.lua)
- leader keys: mapleader and maplocalleader set to space.
- UI: termguicolors enabled; NVIM_TUI_ENABLE_TRUE_COLOR set; showmode disabled; number and relativenumber enabled; cursorline enabled; signcolumn always on; numberwidth set to 2; pumheight set to 10.
- clipboard: clipboard=unnamedplus scheduled on UiEnter.
- undo: undofile enabled; undodir set to ~/.config/nvim/cache/undodir.
- search: ignorecase + smartcase.
- timing: updatetime 300; timeoutlen 300.
- splits: splitright + splitbelow.
- whitespace: list enabled; listchars set to tab, trail, nbsp.
- inccommand set to split.
- scrolling: scrolloff 10.
- confirm on unsaved changes enabled.
- insert and indent: backspace=indent,eol,start; whichwrap=b,s,<,>,h,; wrap disabled; autoindent + smartindent enabled; tabstop 2; softtabstop 2; shiftwidth 2; smarttab enabled; expandtab enabled.
- swap/backup: backup disabled; swapfile disabled.
- cmdheight set to 1.
- terminal cursor shape: insert and normal cursor escape codes; visual bell disabled; t_ut cleared.
- autocmds inside options: TermOpen starts in insert; BufReadPost restores last cursor position; BufEnter runs lcd %:p:h.
- shortmess set to filnxtToOScIF.
- diagnostics: update_in_insert false; severity_sort true.
- python host: python3_host_prog set to $PYTHON.
- misc: wildmenu enabled; deprecated_warnings disabled.

## global autocmds (custom/autocmd.lua)
- TextYankPost triggers vim.hl.on_yank highlight.
- BufWinEnter removes formatoptions t/c/o (via scheduled callback).

## keymaps (custom/keymaps.lua)
- Motion: j/k and <Down>/<Up> become gj/gk when no count; <Esc> clears hlsearch.
- Disable: s and S are nop; ; maps to : in normal/visual; + to <C-a>; _ to <C-x>; , replays register q; \ clears hlsearch.
- Quick delete: <BS> in normal uses "_ciw; <C-h> in insert deletes word with a conditional expr.
- Cmdline: <C-a> to <home>; <C-e> to <end>.
- Clipboard-safe edits: x, c, p/P in visual set to use blackhole or keep yanks; Y maps to y$.
- Visual indent: < and > keep selection.
- Select all: <M-a> = ggVG.
- Emacs insert: <C-a> to line start; <C-e> to line end.
- Buffers: <S-h>/<S-l> prev/next; tml/tmh move bufferline; <leader>bd delete buffer (keep window); <leader>bo delete other buffers; <leader>bD delete buffer and window.
- Tabs: te/tE open tab; th/tl prev/next tab.
- Diagnostics: <leader>q opens loclist.
- Terminal: <Esc><Esc> exits terminal mode; | switches window; <C-q> closes terminal window.
- Windows: <C-h/j/k/l> move focus; sv/sp split; sc/so close; sh/sl/sk/sj navigate; s= equalize; <M-.>/<M-,>/<M-d>/<M-u> resize with expr.
- Save/quit: Q = q!; S runs MagicSave.
- Terminal split: tt opens 10-line terminal.
- Wrap toggle: \w toggles wrap via expr.
- Line movement: 0 runs MagicMove in normal/visual.
- CamelCase/snake_case toggle: T/t call MagicToggleHump.
- Custom functions defined: MagicMove, MagicSave (mkdir -p and sudo write for acwrite), MagicToggleHump.
- Loads hacks: require 'hacks.compile' and 'hacks.markdown'.

## LSP core (custom/lsp/init.lua)
- LspAttach: sets keymaps; sets document highlights; enables inlay hint toggle <leader>th when supported; configures diagnostics (update_in_insert false, virtual_text with spacing and prefix, severity_sort true).
- Mason setup: installs clangd, gopls, pyright, lua-language-server, rust-analyzer, jdtls plus stylua, clang-format, google-java-format.
- LSP servers configured via custom/lsp/servers/*.

## LSP keymaps and highlight
- custom/lsp/keymaps.lua: <C-f> signature_help in insert; <leader>cr rename; <leader>ca code_action.
- custom/lsp/highlight.lua: CursorHold/CursorHoldI highlights references; CursorMoved clears; LspDetach cleanup.

## LSP servers
- clangd (custom/lsp/servers/clangd.lua): background-index on; clang-tidy disabled; detailed completion; header insertion iwyu; fallback-style none; limit-results 200; limit-references 2000; pch-storage memory; offset-encoding utf-16; filetypes include c/cpp/objc/objcpp/cuda/proto; root markers include clang and build files.
- jdtls (custom/lsp/servers/jdtls.lua): JVM args Xms256m/Xmx2g/MaxMetaspaceSize 512m/G1GC/StringDedup; workspace in ~/.local/share/jdtls-workspace/<cwd>; root markers for maven/gradle/.git; google-java-format configured; completion favorite static members + import order; contentProvider fernflower.
- pyright (custom/lsp/servers/pyright.lua): diagnosticMode openFilesOnly; autoSearchPaths true; useLibraryCodeForTypes true.
- rust-analyzer (custom/lsp/servers/rust_analyzer.lua): cargo allFeatures + buildScripts enabled + loadOutDirsFromCheck; checkOnSave clippy (allFeatures); imports granularity module + prefix self; inlay hints enabled; diagnostics enabled (experimental false).
- gopls (custom/lsp/servers/gopls.lua): completeUnimported, placeholders, analyses unusedparams/shadow, hints enabled; staticcheck false; root markers go.work/go.mod/.git.
- lua-language-server (custom/lsp/servers/lua_ls.lua): LuaJIT runtime; globals vim/require; workspace library VIMRUNTIME; checkThirdParty false; completion callSnippet Replace.

## Treesitter (custom/plugins/treesitter.lua)
- nvim-treesitter with TSUpdate; ensure_installed: c/cpp/lua/vim/vimdoc/query/java/python/rust/go/markdown/markdown_inline; highlight and indent enabled; no regex highlight.

## Completion and snippets
- blink.cmp (custom/plugins/autocomplete.lua): loads on InsertEnter/CmdlineEnter; LuaSnip as snippet engine; documentation auto-show after 200ms; auto brackets on accept; ghost_text enabled when vim.g.ai_cmp true; sources default lsp/path/snippets/buffer, dictionary for markdown/text/org or inside comment blocks; dictionary uses /usr/share/dict/words; keymaps preset enter with custom <C-y>/<C-o>/<C-e>/<Tab>/<S-Tab>.
- LuaSnip (custom/plugins/snippets.lua): loads friendly-snippets and custom snippets from lua/hacks/snippets; build install_jsregexp.
- Custom snippets:
  - lua/hacks/snippets/all.lua: todo snippet with date and author.
  - lua/hacks/snippets/c.lua: main() template and printf snippet.
  - lua/hacks/snippets/rust.lua: derive/debug helpers, turbofish, println, for, struct, test, testcfg, if.
  - lua/hacks/snippets/python.lua: function template with docstring options, __init__ generator.
  - lua/hacks/snippets/make.lua: Makefile generators for C/C++.
  - lua/hacks/snippets/markdown.lua: blog/rec/learning/reinforcement/working templates.
  - lua/hacks/snippets/tex.lua: empty file.

## Formatting and linting
- conform.nvim (custom/plugins/autoformat.lua): format on save (BufWritePre) unless disabled; timeout 500ms; uses LSP fallback; formatters: stylua, clang-format (c/cpp), goimports, rustfmt, black; toggle autoformat with <leader>uf; manual format with <leader>cf.
- nvim-lint (custom/plugins/lint.lua): triggers on BufWritePost/BufReadPost/InsertLeave; debounce 100ms; no linters configured except fish; supports optional custom linters.

## UI and editing plugins
- which-key (custom/plugins/editor.lua): VeryLazy; delay 200ms; key groups for leader s/t/h.
- todo-comments: VeryLazy; jump next/prev todo with ]t/[t.
- nvim-surround: VeryLazy; default setup.
- vim-suda: VeryLazy for sudo write.
- oil.nvim: file explorer; keymap - opens oil.
- markdown-preview.nvim: commands MarkdownPreview*; runs mkdp#util#install on build; does FileType on config.
- yazi.nvim: VeryLazy; <leader>- opens yazi.
- undotree: VeryLazy; <leader>r toggles.
- nvim-ts-autotag: InsertEnter; ft html/js/ts/tsx/vue.
- wildfire.nvim: VeryLazy; depends on treesitter; default setup.
- nvim-colorizer: enabled for all filetypes; virtualtext color squares; tailwind enabled.
- ts-comments.nvim: VeryLazy; enabled on nvim >= 0.10.
- grug-far: search/replace; <C-g> in normal uses word; <C-g> in visual uses selection.

## Snacks (custom/plugins/snacks.lua)
- snacks.nvim lazy=false priority 1000 with features: bigfile, dashboard, explorer, indent, input, notifier, picker, quickfile, scope, scroll, statuscolumn, words.
- Extensive keymaps for pickers (files, buffers, grep, history, git, diagnostics, help, marks, etc), LSP navigation, zen/zoom, scratch, notifications, buffer delete, rename, git browse, lazygit, terminal, words jumping, and todo search.
- init: VeryLazy sets Snacks debug helpers and toggle mappings for spell, wrap, relativenumber, diagnostics, line number, conceallevel, treesitter, background, inlay hints, indent, dim.

## Dashboard (custom/plugins/dashboard.lua)
- snacks dashboard configured with width, pane gap, autokeys, and preset keys (find file, new file, grep, recent, config, session, lazy, quit).
- Custom ASCII header is configured (large block).

## Colorschemes (custom/plugins/colorscheme.lua)
- Themes installed: everforest, tokyonight, rose-pine, gruber-darker, colorbuddy.
- everforest setup with hard background and styles; tokyonight set with transparent; rose-pine with disabled backgrounds; gruber-darker setup.
- A local plugin entry (dir = stdpath('config')) loads colorscheme rose-pine-main (auto-rotator is present but commented).

## Git integrations
- gitsigns (custom/plugins/gitsigns.lua): keymaps for hunks, preview, blame, diff, and toggles.
- gitsigns (custom/plugins/git.lua): sign characters customized.
- neogit (custom/plugins/git.lua): lazy; cmd Neogit; <leader>gg opens UI; optional dependencies diffview/codediff/telescope/fzf/mini.pick/snacks.

## Search and pickers
- telescope.nvim (custom/plugins/telescope.lua): loads on VimEnter; fzf-native built with make if available; ui-select extension; devicons when Nerd Font; default config only.

## Debugging
- nvim-dap (custom/plugins/debug.lua): dap-ui, mason-nvim-dap, dap-go; keymaps for start/step/breakpoints/ui/terminate.
- Mason installs delve and codelldb.
- DAP configs for python, c/cpp/rust; dap-ui auto-open/close; breakpoint icons set.

## Java
- maven.nvim: ft java, cmds Maven/MavenExec; uses ./mvnw.
- nvim-java: ft java; require('java').setup; enables jdtls.

## TypeScript and other filetypes
- typescript-tools.nvim: ft typescript/typescriptreact/vue.
- typst-preview.nvim: ft typst.
- markdown-preview already listed.

## Remote/extra plugins
- remote-nvim.nvim for SSH/remote editing.
- wxapp.vim for WeChat mini-program dev.
- noice.nvim for UI messages and LSP markdown rendering; depends on nui.nvim and nvim-notify.
- avante.nvim AI assistant (copilot provider) with many dependencies; copilot.lua config disables inline suggestion/panel.
- multicursor.nvim configured with extensive cursor keymaps and highlights.
- fun plugins: cellular-automaton (VeryLazy), typr (cmd Typr/TyprStats).
- indent-blankline (ibl) enabled.
- Comment.nvim configured (note: Event = VeryLazy is written but not quoted; as-is).
- compile-mode.nvim: <leader>mm and <leader>mM; compile_mode.input_word_completion true.
- compile_dev.lua returns empty (disabled).
- trouble.nvim diagnostics/symbols list with keys <leader>xx/xX/t/cs/cl/xL/xQ.
- project rooter (vim-rooter): root patterns for Maven/Gradle/src/.git; silent chdir; sources .vim.lua at project root on VimEnter.

## Custom hacks
- lua/hacks/compile.lua: keymap 'com' runs compileRun; handles C/C++ build/run with make or g++/gcc; integrates DAP if available; supports markdown/typst/javascript/lua/tex/go/python/rust/cs/java/haskell run/compile actions.
- lua/hacks/markdown.lua: markdown insert-mode mappings for templates and placeholders.
- lua/hacks/health.lua: checkhealth helper for nvim version and executables git/make/unzip/rg.

## Filetype settings (after/ftplugin)
- c.lua: shiftwidth 2; formatoptions remove o.
- cpp.lua: shiftwidth 2; formatoptions remove o.
- java.lua: tabstop/softtabstop/shiftwidth 2; formatoptions remove o.
- go.lua: tabstop/softtabstop/shiftwidth 2.
- rust.lua: tabstop/softtabstop/shiftwidth 4; formatoptions remove o.
- lua.lua: tabstop/softtabstop/shiftwidth 2; formatoptions remove o; <leader>x executes line; <leader><leader>x sources file.
- css.lua/html.lua/javascript.lua: tabstop/softtabstop/shiftwidth 2; javascript removes formatoptions o.

## Performance hot spots (likely causes of slowdown)
These are the main settings/plugins that can cause lag or higher CPU usage, especially on large C/Java projects.
- LSP servers: clangd background indexing and PCH in memory; jdtls runs a full Java language server; rust-analyzer runs clippy on save and build scripts; gopls runs analyses and hints. All can be heavy on large workspaces.
- LSP document highlight (custom/lsp/highlight.lua): CursorHold/CursorHoldI triggers documentHighlight, which can be expensive on big files.
- Diagnostics + signs + virtual text: although update_in_insert is off, diagnostics and virtual text still update on changes and can be heavy with many errors.
- treesitter highlight + indent: enabled for many languages; large files or complex grammars can slow rendering.
- indent-blankline (ibl) and snacks.indent: both draw indentation guides; can add redraw cost.
- nvim-colorizer: enabled for all filetypes with virtual text; large files can slow screen updates.
- snacks.nvim: words, scroll, statuscolumn, picker, notifier, scope features add runtime hooks; mostly fine but can add overhead in big buffers.
- noice.nvim: overrides LSP markdown rendering; can add overhead to hover/signature UI.
- gitsigns: diff tracking in large repos can be costly, especially with many file changes.
- vim-rooter + BufEnter lcd: auto chdir on every buffer enter can be slow on remote/network filesystems.
- autocomplete (blink.cmp) with treesitter-based menu drawing and dictionary source in comments can add CPU during typing.
- conform.nvim format on save: running clang-format/goimports/rustfmt/black can be slow on big files.
- nvim-lint on InsertLeave/BufReadPost/BufWritePost: if you add more linters later, it can add noticeable latency.
