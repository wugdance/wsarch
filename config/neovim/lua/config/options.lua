-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.keymap.set({ "n", "v", "o" }, "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Ignore case by default...
vim.opt.ignorecase = true
-- ... but respect case if at least one capital letter exists.
vim.opt.smartcase = true

-- Show matches while you are typing the search pattern. So in a long file
-- you'll jump to the place where first match is.
vim.opt.incsearch = true
-- Highlights all matches of the last search pattern in the buffer.
vim.opt.hlsearch = true

vim.opt.colorcolumn = "79"
vim.opt.number = true
vim.opt.relativenumber = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

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
-- Always keep lines above/below cursor unless at start/end of file.
vim.o.scrolloff = 4

-- Yank to system clipboard.
vim.opt.clipboard = "unnamedplus"

vim.opt.laststatus = 2 -- Always show the status line.

-- Set the status line in one go
-- %f    -> file name
-- %m    -> mode
-- %r    -> readonly flag
-- %l:%L -> line number:total lines
-- %p%%  -> percentage of the file
vim.opt.statusline = "%f %m %r%=%l:%L      %p%%"

vim.opt.winborder = "rounded"
