return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>f",
            function()
                require("conform").format({ async = true })
            end,
            mode = "",
            desc = "Format buffer",
        },
    },
    -- This will provide type hinting with LuaLS.
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Define your formatters
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_fix", "ruff_organize_imports", "ruff_format" },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = { timeout_ms = 500 },
        formatters = {
            stylua = {
                append_args = {
                    "--indent-type",
                    "Spaces",
                    "--indent-width",
                    "4",
                    "--column-width",
                    "79",
                },
            },
            ruff_format = {
                append_args = { "--line-length", "79" },
            },
        },
    },
}
