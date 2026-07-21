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

vim.keymap.set("n", "<leader>q", function()
    require("sqlcmd").execute_sql("buffer")
end, { desc = "Execute SQL query from buffer." })

vim.keymap.set(
    "v",
    "<leader>q",
    [[:<C-u>lua require("sqlcmd").execute_sql_from_marks()<CR>]],
    { desc = "Execute SQL query from selection." }
)
