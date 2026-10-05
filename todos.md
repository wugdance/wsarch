- [ ] treesitter-objects
- [ ] fzf git pick changes for commit with preview
- [ ] lazydev for neovim
- [ ] own colorscheme

1. Codex has erros during bash command execution:

```text
└ /home/wugdance/wsarch/config/bash/fzf.sh: line 8: bind: warning: line editing not
enabled
… +64 lines (ctrl + t to view transcript)
E886: System error while opening temporary ShaDa file /home/wugdance/.local/state/
nvim/shada/main.shada.tmp.c for writing: read-only file system

```

03. Research Neovim sessions with `mini.sessions`
    - Understand what should be persisted: buffers, splits, tabs, cursor
      positions.
    - Decide whether sessions should be automatic or manual.
    - Test Neovim session restore separately from tmux.
    - Only after that, evaluate whether `tmux-resurrect` should integrate with
      Neovim sessions.
04. migrating to `vim.pack`.
05. Improve neovim python dev experience:
    - make import string from python buffer
    - make pytest command from python buffer
    - pydantic model snippet
06. Research Neovim sessions with `mini.sessions`
    - Understand what should be persisted: buffers, splits, tabs, cursor
      positions.
    - Decide whether sessions should be automatic or manual.
    - Test Neovim session restore separately from tmux.
    - Only after that, evaluate whether `tmux-resurrect` should integrate with
      Neovim sessions.
07. Automated wsarch setup.
08. LSP Symbols with a side bar.
09. Codex speach-to-text mode.
10. debugger for python
11. Yellow warning after changin config that own the current neovim state.
12. What modern neovim 0.12 features are missed in my config? (sure about
    undotree)
13. neovim keymap to the next location from location list or quickfix list or
    next diagnostic.
14. `mini-input` for dynamic keymaps that need input data.
15. `mini-notify` - but for what?
16. review flow
17. making sqlcmd plugin with learning lua
18. open MR for the current branch (bash).
