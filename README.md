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

## Completion and AI suggestions

Completion uses Blink's `enter` preset with explicit selection. Copilot is a menu
source provided by `blink-copilot`, reusing the existing Copilot LSP server and login.
Custom templates remain in `lua/hacks/snippets/`.
Copilot candidates are sorted before other sources; each group retains Blink's
normal fuzzy ranking.

| Insert-mode key | Action |
| --- | --- |
| `Enter` / `Ctrl-y` | Accept the explicitly selected completion candidate. Enter with no selection inserts a newline. |
| `Ctrl-n` / `Ctrl-p`, arrows | Select candidates without inserting them into the buffer. |
| `Ctrl-o` | Open completion or toggle its documentation. |
| `Ctrl-e` | Cancel completion and clear the ghost preview. |
| `Tab` / `Ctrl-i` | Jump forward within a snippet; otherwise ordinary Tab. Never accept AI or apply NES in insert mode. |
| `Shift-Tab` | Jump to the previous snippet placeholder. |

The menu includes LSP, paths, snippets, buffer words, and candidates labelled
`Copilot`; prose filetypes retain dictionary completion. Nothing is preselected
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

Sidekick CLI mappings and normal-mode `Tab` for next edit suggestions are unchanged.
`Alt-l` and `Ctrl-s` are not assigned to this completion workflow.
