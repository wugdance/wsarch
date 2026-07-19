local M = {}

local function trim(s)
    return s:match("^%s*(.-)%s*$") or ""
end

function M.write_stream(raw, out_path, max_rows)
    local file, err = io.open(out_path, "w")
    if not file then
        return nil, "Cannot open output file: " .. err
    end

    local lines = vim.split(raw, "\n", { plain = true })
    local header_written = false
    local row_count = 0
    local total_found = 0

    for _, line in ipairs(lines) do
        local t = trim(line)
        if t ~= "" then
            if
                t:match("%d+ rows? affected")
                or t:gsub("[%s|]", ""):match("^%-+$")
            then
            elseif not header_written then
                local cells = vim
                    .iter(vim.split(t, "|", { plain = true }))
                    :map(trim)
                    :totable()
                file:write("| " .. table.concat(cells, " | ") .. " |\n")

                local seps = vim
                    .iter(cells)
                    :map(function()
                        return "---"
                    end)
                    :totable()
                file:write("| " .. table.concat(seps, " | ") .. " |\n")

                header_written = true
            else
                total_found = total_found + 1
                if row_count < max_rows or max_rows == 0 then
                    local cells = vim
                        .iter(vim.split(t, "|", { plain = true }))
                        :map(trim)
                        :totable()
                    file:write("| " .. table.concat(cells, " | ") .. " |\n")
                    row_count = row_count + 1
                end
            end
        end
    end

    file:close()

    if not header_written then
        os.remove(out_path)
        return 0, 0
    end

    return row_count, total_found
end

return M
