require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.bigfile")
require("config.lsp")
require("config.local")

vim.api.nvim_create_autocmd("VimEnter", {
    desc = "Load oil.nvim when opening a directory",
    once = true,
    callback = function()
        local args = vim.fn.argv()
        if #args == 0 then
            require("lazy").load({ plugins = { "oil.nvim" } })
        elseif vim.fn.isdirectory(args[1]) == 1 then
            require("lazy").load({ plugins = { "oil.nvim" } })
            vim.cmd("edit!")
        end
    end,
})
