local servers = { "ty", "ruff", "luals", "marksman" }
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
    "<leader>rf",
    vim.lsp.buf.references,
    { desc = "Show references." }
)
vim.keymap.set(
    "n",
    "<leader>d",
    vim.diagnostic.open_float,
    { desc = "Open float diagnostic." }
)
vim.keymap.set(
    "n",
    "<leader>bd",
    vim.diagnostic.setloclist,
    { desc = "Add buffer diagnostic to the location list." }
)
