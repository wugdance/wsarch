local servers = { "pyrefly", "ruff", "luals" }
for _, server in ipairs(servers) do
    vim.lsp.enable(server)
end

vim.keymap.set(
    "n",
    "gd",
    vim.lsp.buf.definition,
    { desc = "Go to definition." }
)
vim.keymap.set(
    "n",
    "<leader>rn",
    vim.lsp.buf.rename,
    { desc = "Perfom rename." }
)
vim.keymap.set(
    "n",
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
