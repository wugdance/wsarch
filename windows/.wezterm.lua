local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- tmux is the source of truth for multiplexing. WezTerm is only a GUI
-- terminal front-end for the primary Arch WSL environment.
config.wsl_domains = {
    {
        name = "WSL:archlinux",
        distribution = "archlinux",
        default_cwd = "~",
    },
}
config.default_domain = "WSL:archlinux"

-- tmux owns tabs/windows/panes. Keep WezTerm's own tab model disabled.
config.enable_tab_bar = false

-- Preserve the existing visual setup. GlazeWM owns outer spacing; tmux owns
-- internal pane styling. Do not add WezTerm padding here.
config.window_decorations = "RESIZE"

-- One glass surface: WezTerm owns the window material. tmux and Neovim use
-- transparent backgrounds rather than adding separate blur layers.
config.window_background_opacity = 0.92
config.win32_system_backdrop = "Acrylic"
config.color_scheme = "rose-pine"

-- JetBrains Mono is WezTerm's current effective main font. Symbols Nerd Font
-- Mono remains the icon/symbol fallback. Updating the installed Symbols font
-- is deferred to a follow-up.
config.font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "Symbols Nerd Font Mono",
})
config.font_size = 14.0

-- tmux keeps 50,000 lines of real history. WezTerm scrollback is only for the
-- brief raw-shell/PowerShell fallback path.
config.scrollback_lines = 3500

-- tmux owns persistent sessions, so WezTerm windows are disposable views.
config.window_close_confirmation = "NeverPrompt"

-- The deploy script writes the canonical config; WezTerm should apply it
-- without requiring a manual restart.
config.automatically_reload_config = true

config.keys = {
    -- Keep the current workaround for TUI/chat-style tools that need
    -- Shift+Enter to insert a newline. This intentionally emulates a
    -- bracketed-paste newline. Replacing it with a cleaner enhanced-keyboard
    -- solution is deferred.
    {
        key = "Enter",
        mods = "SHIFT",
        action = act.SendString("\x1b[200~\n\x1b[201~"),
    },

    -- Direct PowerShell escape hatch. This intentionally replaces WezTerm's
    -- default command palette binding because the palette is not part of the
    -- tmux-centric workflow.
    {
        key = "p",
        mods = "CTRL|SHIFT",
        action = act.SpawnCommandInNewWindow({
            domain = { DomainName = "local" },
            cwd = wezterm.home_dir,
            args = { "powershell.exe" },
        }),
    },
    {
        key = "v",
        mods = "CTRL",
        action = act.PasteFrom("Clipboard"),
    },
}

-- Explicit allowlist: do not turn every URL/email into a link. Only the work
-- ticket format used by the current workflow is clickable.
config.hyperlink_rules = {
    {
        regex = [[\b(SDMT-\d+)\b]],
        format = "https://jit.o3.ru/browse/$1",
        highlight = 1,
    },
}

config.mouse_bindings = {
    -- Outside mouse reporting: plain click completes selection but never
    -- opens a link. This deliberately replaces WezTerm's default
    -- CompleteSelectionOrOpenLinkAtMouseCursor behavior.
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = act.CompleteSelection("ClipboardAndPrimarySelection"),
    },

    -- Ctrl+Click opens links outside mouse-reporting contexts.
    {
        event = { Down = { streak = 1, button = "Left" } },
        mods = "CTRL",
        mouse_reporting = false,
        action = act.OpenLinkAtMouseCursor,
    },
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        mouse_reporting = false,
        action = act.Nop,
    },

    -- Ctrl+Click opens links even when tmux/Neovim enable mouse reporting.
    -- This is the primary case for the user's workflow.
    {
        event = { Down = { streak = 1, button = "Left" } },
        mods = "CTRL",
        mouse_reporting = true,
        action = act.OpenLinkAtMouseCursor,
    },
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        mouse_reporting = true,
        action = act.Nop,
    },
}

return config
