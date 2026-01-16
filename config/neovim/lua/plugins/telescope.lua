return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        -- { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    keys = {
        {
            '<leader>sf', 
            function()
                require('telescope.builtin').find_files()
            end,
            desc = 'Find files in cwd.',
        },
        {
            '<leader>sg', 
            function()
                require('telescope.builtin').live_grep()
            end,
            desc = 'Live grep in cwd.',
        },
    },
    opts = {
        pickers = {
            find_files = {
                file_ignore_patterns = { '%.git' },
                hidden = true,
            },
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")
        telescope.setup(opts)

        telescope.load_extension('fzf')
    end,
}
