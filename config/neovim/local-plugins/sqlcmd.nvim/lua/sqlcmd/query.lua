--- Read SQL text from the current buffer or a visual selection.

local M = {}

--- Read SQL text from a buffer, visual range, or visual-mode mark data.
---@param source string
---@param range_start? integer
---@param range_end? integer
---@param start_col? integer
---@param end_col? integer
---@return string?
function M.get_text(source, range_start, range_end, start_col, end_col)
    local lines

    if source == "buffer" then
        lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    elseif source == "visual" then
        if start_col and end_col then
            lines = vim.api.nvim_buf_get_text(
                0,
                range_start - 1,
                start_col,
                range_end - 1,
                end_col,
                {}
            )
        else
            lines = vim.api.nvim_buf_get_lines(
                0,
                range_start - 1,
                range_end,
                false
            )
        end
    end

    if #lines == 0 or (#lines == 1 and lines[1] == "") then
        return nil
    end

    if lines[#lines] == "" then
        table.remove(lines)
    end

    return table.concat(lines, "\n")
end

return M
