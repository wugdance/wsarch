# WezTerm

## Source of truth and deploy

The canonical configuration is `windows/.wezterm.lua`. It is deployed to the
Windows profile as `C:\Users\<WindowsUser>\.wezterm.lua`.

Deploy it with:

```bash
./windows/deploy-wezterm.sh
```

The script validates the candidate config with WezTerm first, then overwrites
the active config directly. It does not create a backup; roll back by checking
out the desired version from Git.

## Ownership boundaries

tmux owns sessions, panes, tabs/windows, scrollback, copy mode, and titles.
WezTerm is the GUI window, WSL domain selector, PowerShell escape hatch, font
renderer, and hyperlink renderer. Do not recreate multiplexing in WezTerm.

## Startup and domains

WezTerm starts in the `WSL:archlinux` domain at `~`. It does not automatically
attach tmux. `Ctrl+Shift+p` opens PowerShell in the Windows user profile.

## Glass material

WezTerm owns the single glass surface. The Windows config uses Acrylic with
`window_background_opacity = 0.94`. tmux and Neovim use transparent/default
backgrounds so they do not paint over that material. They keep Rose Pine
accents for contrast, and neither multiplexer adds its own blur or blend layer.
The Neovim status line intentionally keeps its current styling for now.

## Input

The tmux prefix is `Ctrl+Space`; there is no WezTerm leader. Terminal paste uses
`Ctrl+Shift+v`. Plain `Ctrl+v` is intentionally left available to applications
such as Neovim, where it means visual block mode.

`Shift+Enter` sends a bracketed-paste newline as an intentional workaround for
TUI/chat-style tools. It remains in place until enhanced keyboard encoding is
adopted.

## Links

Only work tickets matching `SDMT-\d+` are linked, to
`https://jit.o3.ru/browse/<ticket>`. Activate a link with `Ctrl+Click`, including
while tmux or Neovim is using mouse reporting. Plain click never opens links.

## Known deferred work

- Update Symbols Nerd Font Mono to v3.5.1.
- Add the Telescope/`mini.icons` provider mock.
- Add WezTerm bootstrap/install.
- Revisit a QuickSelect experiment later.
