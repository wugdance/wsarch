return {
    "stevearc/aerial.nvim",
    opts = {
        layout = {
            min_width = 48,
            default_direction = "prefer_left",
        },
        -- Use Aerial's built-in Nerd Font icons instead of mini.icons/lspkind.
        nerd_font = true,
        use_icon_provider = false,
    },
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        -- Still available for other plugins, but Aerial will not use it.
        { "nvim-mini/mini.icons", opts = {} },
    },
    keys = {
        {
            "<leader>st",
            "<cmd>AerialToggle<cr>",
            mode = { "n" },
            desc = "Toggle symbols sidebar.",
        },
    },
}
