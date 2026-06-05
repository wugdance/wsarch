local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.default_prog = { "powershell.exe" }
config.keys = {
    {
        key = "v",
        mods = "CTRL",
        action = wezterm.action.PasteFrom("Clipboard"),
    },
    {
        key = "Enter",
        mods = "SHIFT",
        action = wezterm.action.SendString("\x1b[200~\n\x1b[201~"),
    },
}
config.window_background_opacity = 1
config.color_scheme = "rose-pine"

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.font_size = 18.0

return config
