return {
    dir = vim.fs.joinpath(
        vim.fn.stdpath("config"),
        "local-plugins",
        "scroll.nvim"
    ),
    name = "scroll.nvim",
    cmd = { "TmuxScrollback" },
    dependencies = {
        { "m00qek/baleia.nvim", version = "*" },
    },
    opts = {
        transport_buffer_name = "wsarch-scrollback",
    },
    config = function(_, opts)
        require("scroll").setup(opts)
    end,
}
