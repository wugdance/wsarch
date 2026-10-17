return {
    dir = vim.fs.joinpath(
        vim.fn.stdpath("config"),
        "local-plugins",
        "python.nvim"
    ),
    name = "python.nvim",
    keys = {
        {
            "<leader>pt",
            function()
                require("python").copy_pytest_command()
            end,
            mode = "n",
            desc = "Copy pytest command for current test.",
        },
    },
    opts = {
        pytest = {
            command = "uv run pytest",
            flags = { "-s", "-v" },
        },
    },
    config = function(_, opts)
        require("python").setup(opts)
    end,
}
