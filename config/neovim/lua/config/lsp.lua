vim.lsp.enable("ruff")
vim.lsp.enable("pylsp")
vim.lsp.enable("luals")

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition." })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Perfom rename." })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Pefrom code action." })
