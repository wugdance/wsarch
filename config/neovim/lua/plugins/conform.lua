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
            python = { "ruff_organize_imports", "ruff_format" },
            markdown = { "mdformat" },
        },
        -- Set default options
        default_format_opts = {
            lsp_format = "fallback",
        },
        -- format_on_save = { timeout_ms = 500 },
        format_on_save = function(bufnr)
            local bufname = vim.api.nvim_buf_get_name(bufnr)
            local filetype = vim.bo[bufnr].filetype

            if
                filetype == "markdown" and string.match(bufname, "/opencode/")
            then
                -- Return nothing to skip format on save
                return
            end

            return { timeout_ms = 500, lsp_format = "fallback" }
        end,
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
            mdformat = {
                append_args = { "--wrap", "79", "--number" },
            },
        },
    },
}
