local M = {}

local output_win = nil
local large_buffer_threshold = 500

local function setup_result_win(win)
    local buf = vim.api.nvim_win_get_buf(win)

    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

    vim.api.nvim_buf_set_keymap(
        buf,
        "n",
        "q",
        "<cmd>bdelete<CR>",
        { noremap = true, silent = true, desc = "Close results" }
    )

    local num_lines = vim.api.nvim_buf_line_count(buf)
    if num_lines > large_buffer_threshold then
        vim.api.nvim_buf_set_option(buf, "synmaxcol", 200)
        vim.api.nvim_buf_set_option(buf, "foldenable", false)
    end
end

function M.open_result(out_path)
    if output_win and vim.api.nvim_win_is_valid(output_win) then
        local buf = vim.api.nvim_win_get_buf(output_win)
        vim.api.nvim_set_current_win(output_win)
        vim.api.nvim_buf_set_option(buf, "modifiable", true)
        vim.api.nvim_buf_set_lines(
            buf,
            0,
            -1,
            false,
            vim.fn.readfile(out_path)
        )
        vim.api.nvim_buf_set_option(buf, "modifiable", false)
        vim.api.nvim_buf_set_option(buf, "modified", false)

        setup_result_win(output_win)
        return
    end

    vim.cmd("rightbelow split " .. vim.fn.fnameescape(out_path))
    output_win = vim.api.nvim_get_current_win()

    local buf = vim.api.nvim_win_get_buf(output_win)
    vim.api.nvim_buf_set_option(buf, "bufhidden", "delete")

    setup_result_win(output_win)
end

return M
