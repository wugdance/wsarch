return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    keymaps = {
      ['<C-h>'] = false,
      ['<C-l>'] = false,
      ['<C-r>'] = 'actions.refresh',
    },
    watch_for_changes = true,
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
      {'<leader>o', '<CMD>Oil<CR>', desc = 'Open Oil'},
  },
  -- Lazy loading is not recommended because it is very tricky to make 
  -- it work correctly in all situations.
  lazy = false,
}
