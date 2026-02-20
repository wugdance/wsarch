return {
    "rose-pine/neovim",
    priority = 1000, -- Make sure to load this before all the other start plugins.

    init = function()
        require("rose-pine").setup({
            dark_variant = "main",

            styles = {
                bold = false,
                italic = false,
            },
            highlight_groups = {
                TelescopeBorder = { fg = "highlight_high", bg = "none" },
                TelescopeNormal = { bg = "none" },
                TelescopePromptNormal = { fg = "text", bg = "none" },
                TelescopeResultsNormal = { fg = "subtle", bg = "none" },
                TelescopeSelection = { fg = "text", bg = "surface" },
                TelescopeSelectionCaret = { fg = "rose", bg = "rose" },

                BlinkCmpDocBorder = { fg = "highlight_high", bg = "none" },
                BlinkCmpDoc = { fg = "text", bg = "none" },
                BlinkCmpDocSeparator = { fg = "highlight_high", bg = "none" },

                Pmenu = { fg = "highlight_high", bg = "none" },
                PmenuSel = { fg = "text", bg = "surface" },
                PmenuThumb = { fg = "rose", bg = "rose" },

                FloatBorder = { fg = "highlight_high", bg = "none" },
                NormalFloat = { fg = "text", bg = "none" },

                StatusLine = { fg = "love", bg = "love", blend = 10 },
                StatusLineNC = { fg = "subtle", bg = "surface" },
            },
        })
        vim.o.background = "dark"

        vim.cmd.colorscheme("rose-pine")

        -- Enbale true color support
        vim.o.termguicolors = true
    end,
}
