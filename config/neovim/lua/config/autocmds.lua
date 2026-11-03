vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking text.",
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Check if we need to reload the file when it changed.",
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    desc = "Resize splits if window got resized.",
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})
