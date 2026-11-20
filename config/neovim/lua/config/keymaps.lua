-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
    desc = "Clear highlighted search matches.",
})

-- Load the builtin optional undotree plugin only when first requested.
vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, {
    desc = "Toggle undotree.",
})

vim.keymap.set("n", "<leader>bn", function()
    local path = vim.api.nvim_buf_get_name(0)
    if vim.bo.filetype == "oil" then
        path = require("oil").get_current_dir() or path
    end
    path = vim.fs.relpath(vim.loop.cwd(), path) or path
    vim.fn.setreg("+", path)
    vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, {
    desc = "Copy current path",
})

-- Delete without polluting `"` register.
vim.keymap.set({ "n", "v" }, "<leader>d", function()
    return '"_d'
end, { expr = true })
