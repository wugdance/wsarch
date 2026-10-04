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
05. Glass material design.
06. Improve neovim python dev experience:
    - make import string from python buffer
    - make pytest command from python buffer
    - pydantic model snippet
07. Research Neovim sessions with `mini.sessions`
    - Understand what should be persisted: buffers, splits, tabs, cursor
      positions.
    - Decide whether sessions should be automatic or manual.
    - Test Neovim session restore separately from tmux.
    - Only after that, evaluate whether `tmux-resurrect` should integrate with
      Neovim sessions.
08. Automated wsarch setup.
09. LSP Symbols with a side bar.
10. Codex speach-to-text mode.
11. debugger for python
12. Yellow warning after changin config that own the current neovim state.
13. What modern neovim 0.12 features are missed in my config?
