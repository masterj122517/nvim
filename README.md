I've been using neovim from 2020 i guess, it's really a big part in my developer's life  
however, i have made a lot of configurations during the time  
At first, i was following *The CW*'s configuration, within few days i feel not satisfied
so i started my own configuration(using vimplug i guess back the day)  
after that, whenever there's a new plugin master in neovim plugin community, i started to make a new configuration
Now I am using My Config of LazyVim inspired by *devaslife*  
Am I satisfied? I don't now  
It's kind strange to use a distro that i'm  not fully understand what it actually doing. It's fast not gonna lie, But whenever i encounter something wrong, i have no idea how to fix it.
As the time goes by, I've gained more coding skills and understand what's the *right* path  
A lot people said config ur text editor it's a waste of time, even i think like this way sometimes  
But I do like Neovim and i do want to understand how things works

So, Today, I'm going to config my text editor one more time(maybe the last time)

I will write down the whole journey of me making this text editor
it's suit all my needs and try to be as much minimal as it could

Without further ado, let's get started

Let's think what it's my needs(what does a IDE do)

Syntax highlighting

Autocomplete

Fuzzy finding

Colorscheme

debugging

So, we will start with *kickstart.nvim*

Well Well Well, I guess that's the finally version
everything works just really great
all in all this is what you will need in the future

## Opt-in language extras

Language configuration uses ordinary lazy.nvim imports, not the LazyVim distro.
Choose languages in `lua/custom/languages.lua`. Only Lua is enabled by default;
uncomment the imports you want and restart Neovim:

```lua
return {
  { import = 'custom.extras.lang.lua' },
  { import = 'custom.extras.lang.odin' },
  { import = 'custom.extras.lang.zig' },
  { import = 'custom.extras.lang.rust' },
  { import = 'custom.extras.lang.typescript' }, -- JS, TS, JSX and TSX
}
```

An extra configures completion capabilities, LSP actions, buffer-local language
options and Conform formatters. An unimported extra does nothing, even if its
server is already installed. An imported server starts on matching files only
when its executable is available. Missing servers are silently skipped; install
them yourself and restart Neovim. Missing formatters use the existing LSP
formatting fallback where the attached server supports it.

| Import suffix | LSP executable(s) | Formatter executable(s) |
| --- | --- | --- |
| `lua` | `lua-language-server` | `stylua` |
| `odin` | `ols` | `odinfmt` |
| `zig` | `zls` | `zig` (`zig fmt`) |
| `rust` | `rust-analyzer` | `rustfmt` |
| `typescript` | `vtsls`; optional `vscode-eslint-language-server`, `biome` | `biome` in Biome projects, otherwise `prettierd` |
| `deno` | `deno` | LSP formatting |
| `c` | `clangd` | `clang-format` |
| `go` | `gopls` | `goimports` |
| `python` | `pyright-langserver` | `black` |
| `java` | `jdtls` (requires JDK 21+) | `google-java-format` |
| `web` | TypeScript plus HTML/CSS, Vue, Angular, Astro, Svelte, Tailwind, Emmet, JSON/YAML, GraphQL, MDX and Prisma servers | `biome` / `prettierd` |

Install servers/formatters through your package manager, language toolchain, or
manually with Mason, for example:

```vim
:MasonInstall ols zls rust-analyzer vtsls
```

Mason is retained as a manual installer and adds its installed binaries to
Neovim's `PATH`. There is no Mason tool-installer or LSP installation list.
Compilers/toolchains remain your responsibility: Odin for OLS, Zig for `zig fmt`,
Rust/Cargo for rust-analyzer, Node.js for vtsls, and JDK 21+ for current jdtls.
For Java, select the server's JDK with `JAVA_HOME`; this does not require changing
the Java target version of your projects.

`typescript` does not import the whole Web stack. `web` also imports TypeScript
and retains the package-script, dependency-management and test keybindings.
`deno` is separate: it activates only beneath `deno.json` / `deno.jsonc`, and
vtsls skips those projects so both servers do not attach to the same buffer.
TypeScript/JavaScript files outside a project use their containing directory.

Treesitter uses already-installed parsers; startup no longer installs parsers
for every language. Install syntax support explicitly when needed:

```vim
:TSInstall odin zig rust javascript typescript tsx
```

Existing DAP, AI and document-preview plugins are separate from language extras.
The debugger's Mason installation settings in `lua/custom/plugins/debug.lua`
are unchanged.

### Overrides and adding languages

Put a normal lazy spec after the imports in `lua/custom/languages.lua` to override
server settings or commands, disable an optional server, or change formatters:

```lua
{
  'neovim/nvim-lspconfig',
  opts = {
    servers = {
      ols = { cmd = { '/absolute/path/to/ols' } },
      eslint = false,
      rust_analyzer = {
        settings = { ['rust-analyzer'] = { checkOnSave = true } },
      },
    },
  },
}
```

New languages follow the same pattern as `lua/custom/extras/lang/zig.lua`: return
LSP `opts.servers`, optional `opts.filetype_options`, and Conform
`opts.formatters_by_ft` specs, then import that module. Server names are
nvim-lspconfig names, not Mason package names. Keep expensive setup inside
lazy `opts` / `config` functions, not at module scope.

Use `:checkhealth vim.lsp` for LSP status, `:ConformInfo` for formatter availability,
`<leader>cf` for formatting, and `<leader>uf` to toggle formatting on save.
Existing rename/code-action mappings and the inlay-hint toggle remain shared.

### Odin projects

With the Odin extra imported and `ols` installed, opening a `.odin` file starts
the server automatically. Keep `odin` on `PATH` so OLS can find the standard
library and run compiler checks.

Root detection uses `ols.json`, `.git`, or the directory containing Odin files.
For custom collections and build profiles, put an `ols.json` file at the project
root; see the [OLS configuration reference](https://github.com/DanielGavin/ols#configuration).

## Completion and AI suggestions

Completion uses Blink's `enter` preset with explicit selection. Copilot completion,
Sidekick next edit suggestions (NES), and the Copilot LSP service are disabled by
default. In normal mode, `<leader>ac` toggles all three for the current Neovim
session; restarting Neovim resets them to disabled. Disabling also clears current
suggestions and stops the Copilot service. When enabled, Copilot is a menu source
provided by `blink-copilot`, using the Copilot LSP server and existing login.
Other completion sources and Sidekick CLI mappings are unaffected.
Custom templates remain in `lua/hacks/snippets/`.
Candidates use Blink's default fuzzy ranking, including match quality, completion
history, nearby words, and built-in source weights, as in LazyVim's Blink extra.
The path source detects path contexts and retains its built-in score boost.
Copilot has no forced first-place comparator or extra score boost, so a relevant
path or LSP candidate can rank ahead of AI suggestions.

| Insert-mode key | Action |
| --- | --- |
| `Enter` / `Ctrl-y` | Accept the explicitly selected completion candidate. Enter with no selection inserts a newline. |
| `Ctrl-n` / `Ctrl-p`, arrows | Select candidates without inserting them into the buffer. |
| `Ctrl-o` | Open completion or toggle its documentation. |
| `Ctrl-e` | Cancel completion and clear the ghost preview. |
| `Tab` / `Ctrl-i` | Jump forward within a snippet; otherwise ordinary Tab. Never accept AI or apply NES in insert mode. |
| `Shift-Tab` | Jump to the previous snippet placeholder. |

The menu includes LSP, paths, snippets, buffer words, and, when enabled, candidates
labelled `Copilot`; prose filetypes retain dictionary completion. Nothing is preselected
or preview-inserted. Only an explicitly selected Copilot candidate shows ghost
text, and only while the menu is open. Selecting another source, closing the
menu, or continuing to type clears the AI preview. Confirmation inserts the
selected candidate. Copilot's independent native inline UI and suggestion
cycling mappings are disabled.

Snippets such as `todo` are selected and expanded through the menu.
Documentation opens automatically after 200 ms for a selected candidate.

Command-line completion uses Blink's `cmdline` preset. `Tab` completes commands;
the menu opens automatically for `:` but not for search. Left/right arrows retain
their ordinary command-line cursor movement.

`Ctrl-h` and `Ctrl-l` no longer control snippets. The original insert-mode
`Ctrl-h` delete-word mapping is preserved. Visual editing mappings remain
Visual-only so they do not intercept typing in snippet Select mode.

Normal-mode `Tab` jumps to or applies next edit suggestions when NES is enabled.
`Alt-l` and `Ctrl-s` are not assigned to this completion workflow.

## Kataware

Kataware is vendored in `colors/kataware.lua` and `lua/kataware/`; updating the
theme requires both paths. No theme plugin download is required.

The palette remains Kataware's indigo/spectral scheme. Ordinary and relative
line numbers use muted blue-gray; the current line number is bold gold.
Configure the theme in `lua/custom/plugins/colorscheme.lua`. Its existing
`vim.g.kataware_transparent = true` setting remains supported.
Alternatively, call `require('kataware').setup { transparent = true }` before
loading the colorscheme; explicit setup options take precedence over the global.

