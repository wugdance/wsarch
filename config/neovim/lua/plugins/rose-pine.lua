return {
  'rose-pine/neovim',
  priority = 1000, -- Make sure to load this before all the other start plugins.

  init = function()
    require('rose-pine').setup {
      dark_variant = 'main',

      styles = {
        bold = false,
        italic = false,
      },
      highlight_groups = {
        TelescopeBorder = { fg = 'highlight_high', bg = 'none' },
        TelescopeNormal = { bg = 'none' },
        TelescopePromptNormal = { bg = 'base' },
        TelescopeResultsNormal = { fg = 'subtle', bg = 'none' },
        TelescopeSelection = { fg = 'text', bg = 'base' },
        TelescopeSelectionCaret = { fg = 'rose', bg = 'rose' },
        FloatBorder = { fg = 'highlight_high', bg = 'none' },
        NormalFloat = { bg = 'none' },
      },
    }
    vim.o.background = 'dark'

    vim.cmd.colorscheme 'rose-pine'

    -- Enbale true color support
    vim.o.termguicolors = true

    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
