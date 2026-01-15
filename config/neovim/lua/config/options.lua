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

vim.o.tabstop = 4 -- how many spaces tab inserts
vim.o.softtabstop = 4 -- how many spaces tab inserts
vim.o.shiftwidth = 4 -- controls number of spaces when using >> or << commands
vim.o.expandtab = true -- use appropriate number of spaces with tab
vim.o.smartindent = true -- indenting correctly after {
vim.o.autoindent = true -- copy indent from current line when starting new line
vim.o.scrolloff = 8 -- always keep 8 lines above/below cursor unless at start/end of file

vim.opt.clipboard = "unnamedplus"
