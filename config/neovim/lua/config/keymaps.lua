-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", {
    desc = "Clear highlighted search matches.",
})

vim.keymap.set("n", "<leader>bn", function()
    local path = vim.fs.relpath(vim.loop.cwd(), vim.api.nvim_buf_get_name(0))
    vim.fn.setreg("+", path)
    vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, {
    desc = "Get current buffer name.",
})

-- sqlcmd related keymaps.

vim.keymap.set("n", "<leader>qr", function()
    require("sqlcmd").execute_sql("buffer")
end, { desc = "Execute SQL query from buffer." })

vim.keymap.set(
    "v",
    "<leader>qr",
    [[:<C-u>lua require("sqlcmd").execute_sql_from_marks()<CR>]],
    { desc = "Execute SQL query from selection." }
)

vim.keymap.set("n", "<leader>qs", function()
    require("sqlcmd").stop_query()
end, { desc = "Stop running SQL query." })

-- Delete without polluting `"` register.
vim.keymap.set({ "n", "v" }, "<leader>d", function()
    return '"_d'
end, { expr = true })
