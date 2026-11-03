return {
  {
    "mrsobakin/multilayout.nvim",
    lazy = false,
    priority = 1001,
    config = function()
      -- Prevent langmap from applying to keys produced by mappings.
      vim.opt.langremap = false

      require("multilayout").setup({
        layouts = { ru = "ru" },
        use_libukb = false,
      })
    end,
  },
  {
    "Wansmer/langmapper.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      use_layouts = { "ru" },
      hack_keymap = true,
      map_all_ctrl = true,
      disable_hack_modes = { "i", "t" },
    },
  },
}
