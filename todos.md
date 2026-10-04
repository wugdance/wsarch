- [ ] add improved pdb for python
- [ ] treesitter-objects
- [ ] macros/commands/mappings/something to init pydantic model
- [ ] fzf git pick changes for commit with preview
- [ ] lazydev for neovim
- [ ] own colorscheme

1. When I open tmux popup it conflicts with a pane that is rendered. For
   example. I have three panes and one of them is active codex agent. And if
   agent working and actively render at the moment it overwrites popup and
   exactly that part of popup that is intersect with this pane.
2. Codex has erros during bash command execution:

```text
└ /home/wugdance/wsarch/config/bash/fzf.sh: line 8: bind: warning: line editing not
enabled
… +64 lines (ctrl + t to view transcript)
E886: System error while opening temporary ShaDa file /home/wugdance/.local/state/
nvim/shada/main.shada.tmp.c for writing: read-only file system

```

03. `mini.surround` add extra spaces with add motion.
04. Research Neovim sessions with `mini.sessions`
    - Understand what should be persisted: buffers, splits, tabs, cursor
      positions.
    - Decide whether sessions should be automatic or manual.
    - Test Neovim session restore separately from tmux.
    - Only after that, evaluate whether `tmux-resurrect` should integrate with
      Neovim sessions.
05. migrating to `vim.pack`.
06. Glass material design.
07. Improve neovim python dev experience:
    - make import string from python buffer
    - make pytest command from python buffer
08. Research Neovim sessions with `mini.sessions`
    - Understand what should be persisted: buffers, splits, tabs, cursor
      positions.
    - Decide whether sessions should be automatic or manual.
    - Test Neovim session restore separately from tmux.
    - Only after that, evaluate whether `tmux-resurrect` should integrate with
      Neovim sessions.
09. Adding global agent folder to config.
10. Automated wsarch setup.
11. Replace tmux copy mode with WezTerm.
