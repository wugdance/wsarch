-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.keymap.set(
    { 'n', 'v', 'o' },
    '<Space>',
    '<Nop>',
    { silent = true, remap = false }
)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.opt.colorcolumn = '79'
vim.opt.number = true
vim.opt.relativenumber = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Disable line wrapping so they stay on a single row.
vim.o.wrap = false

-- How many spaces tab inserts.
vim.o.tabstop = 4 
vim.o.softtabstop = 4 
-- Use appropriate number of spaces with tab.
vim.o.expandtab = true 

-- Controls number of spaces when using >> or << commands.
vim.o.shiftwidth = 4 
-- Indenting correctly after {.
vim.o.smartindent = true 
-- Copy indent from current line when starting new line.
vim.o.autoindent = true 
-- Always keep 8 lines above/below cursor unless at start/end of file.
vim.o.scrolloff = 8 

-- Yank to system clipboard.
vim.opt.clipboard = "unnamedplus"


vim.opt.laststatus = 2 -- Always show the status line.

-- Set the status line in one go
-- %f -> file name
-- %m -> mode
-- %r -> readonly flag
-- %l:%L -> line number:total lines
-- %p%% -> percentage of the file
vim.opt.statusline = '%f %m %r%=%l:%L      %p%%'
