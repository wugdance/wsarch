return {
    "nvim-mini/mini.ai",
    opts = function()
        return {
            n_lines = 500,
            custom_textobjects = {},
        }
    end,
    config = function(_, opts)
        require("mini.ai").setup(opts)
    end,
}
