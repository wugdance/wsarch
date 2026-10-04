-- Declare the ANSI renderer used by the tmux scrollback viewer.
return {
    "m00qek/baleia.nvim",
    version = "*",
    cmd = "TmuxScrollback",
    config = function()
        require("tmux_scrollback").setup()
    end,
}
