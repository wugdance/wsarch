vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

vim.opt.clipboard = "unnamedplus"

-- Manually specify clipboard provider.
-- vim.g.clipboard = {
--     name = "WslClipboard",
--     copy = {
--         ["+"] = "clip.exe",
--         ["*"] = "clip.exe",
--     },
--     paste = {
--         ["+"] = "clip.exe",
--         ["*"] = "clip.exe",
--     },
--     cache_enabled = 0,
-- }
