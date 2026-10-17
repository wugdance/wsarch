local local_config = require("config.local")

return {
    dir = vim.fs.joinpath(
        vim.fn.stdpath("config"),
        "local-plugins",
        "sqlcmd.nvim"
    ),
    name = "sqlcmd.nvim",
    keys = {
        {
            "<leader>qr",
            function()
                require("sqlcmd").execute_sql("buffer")
            end,
            mode = "n",
            desc = "Execute SQL query from buffer.",
        },
        {
            "<leader>qr",
            [[:<C-u>lua require("sqlcmd").execute_sql_from_marks()<CR>]],
            mode = "v",
            desc = "Execute SQL query from selection.",
        },
        {
            "<leader>qs",
            function()
                require("sqlcmd").stop_query()
            end,
            mode = "n",
            desc = "Stop running SQL query.",
        },
    },
    opts = {
        server = local_config.sqlcmd.server,
        database = local_config.sqlcmd.database,
    },
    config = function(_, opts)
        require("sqlcmd").setup(opts)
    end,
}
