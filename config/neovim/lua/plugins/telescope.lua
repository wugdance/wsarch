return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        -- { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
        local telescope_builtin = require("telescope.builtin")
        vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files)
        vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep)
    end,
}
