return {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
        keymaps = {
            ["<C-h>"] = false,
            ["<C-l>"] = false,
            ["<C-r>"] = "actions.refresh",
        },
        watch_for_changes = true,
        view_options = {
            show_hidden = true,
        },
    },
    -- Optional dependencies
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    keys = {
        { "<leader>e", "<CMD>Oil<CR>", desc = "Explore with Oil" },
    },
    lazy = true,
}
