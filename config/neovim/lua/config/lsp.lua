local servers = { "ty", "ruff", "luals" }
for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
})

vim.keymap.set(
    "n",
    "gd",
    vim.lsp.buf.definition,
    { desc = "Go to definition." }
)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename." })
vim.keymap.set(
    { "n", "v" },
    "<leader>ca",
    vim.lsp.buf.code_action,
    { desc = "Pefrom code action." }
)
vim.keymap.set(
    "n",
    "<leader>gr",
    vim.lsp.buf.references,
    { desc = "Show references." }
)
vim.keymap.set(
    "n",
    "<leader>df",
    vim.diagnostic.open_float,
    { desc = "Open float diagnostic." }
)
vim.keymap.set(
    "n",
    "<leader>dq",
    vim.diagnostic.setqflist,
    { desc = "Open quickfix list filled with diagnostic." }
)
