vim.api.nvim_create_autocmd("BufReadPre", {
    desc = "Disable resource-heavy features for large files",
    callback = function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" then
            return
        end

        local ok, stat = pcall(vim.uv.fs_stat, path)
        if not ok or not stat then
            return
        end

        if stat.size < 1024 * 1024 then
            return
        end

        vim.b.ts_highlight = false
        vim.b.miniai_disable = true
        vim.b.minisurround_disable = true
        vim.b.indent_blankline_enabled = false

        vim.opt_local.foldmethod = "manual"
        vim.opt_local.foldenable = false
        vim.opt_local.relativenumber = false
        vim.opt_local.cursorline = false
        vim.opt_local.colorcolumn = ""

        local size_mb = math.floor(stat.size / 1024 / 1024)
        vim.notify(
            string.format("Large file detected (%dMB). Disabled resource-heavy features.", size_mb)
        )
    end,
})
