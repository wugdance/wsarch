return {
    "folke/trouble.nvim",
    opts = {
        win = {
            position = "left",
        },
    }, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
        {
            "<leader>tx",
            "<cmd>Trouble diagnostics toggle win.position=bottom<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>tX",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>ts",
            "<cmd>Trouble symbols toggle focus=false win.position=left win.size=48<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>tl",
            "<cmd>Trouble lsp toggle focus=false win.position=bottom<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>tr",
            "<cmd>Trouble lsp_references toggle focus=false win.position=bottom<cr>",
            desc = "LSP  references ... (Trouble)",
        },
        {
            "<leader>tL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>tQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
    },
}
