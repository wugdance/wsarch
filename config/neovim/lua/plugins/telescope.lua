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
        {
            '<leader>/', 
            function()
                require('telescope.builtin').current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        windblend = 10,
                        previewer = false,
                    }
                )
            end,
            desc = 'Fuzzy search in current buffer.',
        },
    },
    opts = {
        defaults = {
            layout_strategy = 'flex',
            layout_config = {
                horizontal = {
                    preview_width = 0.6,
                },
                vertical = {
                    preview_height = 0.55,
                    prompt_position = 'top',
                    preview_cutoff = 35,
                    width = 0.9,
                },
            },
        },
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
