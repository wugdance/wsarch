--- Interpret sqlcmd results and write them to user-facing buffers.

local format = require("sqlcmd.format")
local ui = require("sqlcmd.ui")

local M = {}

local function output_path(config, name)
    return vim.fs.joinpath(config.output_dir, name)
end

local function write_file(path, data)
    vim.fn.mkdir(vim.fs.dirname(path), "p")

    local file = io.open(path, "w")
    if not file then
        return
    end

    file:write(data)
    file:close()
end

local function should_format(config, total_found, row_count)
    if vim.fn.executable("mdformat") ~= 1 then
        return false
    end

    if config.mdformat_threshold == 0 then
        return true
    end

    return math.max(row_count, total_found) <= config.mdformat_threshold
end

local function finish_cancelled(config, result)
    if #result.stdout == 0 then
        vim.notify("SQL query cancelled.", vim.log.levels.WARN)
        return
    end

    local path = output_path(config, "query-cancelled.md")
    local row_count = format.write_stream(result.stdout, path, config.max_rows)

    if not row_count or row_count == 0 then
        vim.notify("SQL query cancelled.", vim.log.levels.WARN)
        return
    end

    local content = vim.fn.readfile(path)
    table.insert(content, 1, "")
    table.insert(
        content,
        1,
        "> **Query cancelled** — results may be incomplete"
    )
    vim.fn.writefile(content, path)

    ui.open_result(path)
    vim.notify(
        "SQL query cancelled — partial results shown",
        vim.log.levels.WARN
    )
end

local function finish_failure(config, result)
    local raw = result.stdout
    if raw == "" and result.stderr ~= "" then
        raw = result.stderr
    elseif raw == "" and result.stderr == "" then
        raw = result.fallback()
    end

    local path = output_path(config, "query-error.md")
    write_file(path, raw)

    ui.open_result(path)
    vim.notify(
        string.format(
            "SQL query failed (%.1fs): exited with code %d — see output buffer",
            result.elapsed_seconds,
            result.exit_code
        ),
        vim.log.levels.ERROR
    )
end

local function finish_no_rows(config, result, raw)
    if result.exit_code ~= 0 then
        local captured = result.fallback()
        captured = captured ~= "" and captured or "Query failed with no output"
        local path = output_path(config, "query-error.md")
        write_file(path, captured)
        ui.open_result(path)
        vim.notify("Query failed — see output buffer", vim.log.levels.ERROR)
        return
    end

    if vim.trim(raw) == "" then
        vim.notify("Query executed (no output)", vim.log.levels.INFO)
        return
    end

    local path = output_path(config, "query-output.md")
    write_file(path, raw)

    ui.open_result(path)
    vim.notify("Query executed — no table data", vim.log.levels.INFO)
end

local function maybe_format(config, path, total_found, row_count)
    if should_format(config, total_found, row_count) then
        vim.fn.system({ "mdformat", path })
        return
    end

    if
        total_found > config.mdformat_threshold
        and vim.fn.executable("mdformat") == 1
    then
        vim.notify(
            string.format(
                "Skipped mdformat: %d rows exceeds threshold of %d",
                total_found,
                config.mdformat_threshold
            ),
            vim.log.levels.INFO
        )
    end
end

--- Handle a completed sqlcmd process.
---@param config table
---@param result table
function M.finish(config, result)
    if result.cancelled then
        finish_cancelled(config, result)
        return
    end

    if result.exit_code ~= 0 then
        finish_failure(config, result)
        return
    end

    local raw = result.stdout
    local path = output_path(config, "query-output.md")
    vim.fn.mkdir(vim.fs.dirname(path), "p")

    vim.api.nvim_echo({
        { "sqlcmd: writing results... ", "None" },
    }, false, {})

    local row_count, total_found =
        format.write_stream(raw, path, config.max_rows)

    if row_count == nil then
        vim.notify(
            "Failed to write results: " .. tostring(total_found),
            vim.log.levels.ERROR
        )
        return
    end

    if row_count == 0 then
        finish_no_rows(config, result, raw)
        return
    end

    if total_found > row_count then
        local file = io.open(path, "a")
        if file then
            file:write(
                string.format(
                    "\n---\n\n_Showing first %d of %d rows_\n",
                    row_count,
                    total_found
                )
            )
            file:close()
        end
    end

    maybe_format(config, path, total_found, row_count)

    local message = string.format(
        "SQL query completed in %.1fs (%d rows)",
        result.elapsed_seconds,
        row_count
    )
    if total_found > row_count then
        message = message .. string.format(", truncated from %d", total_found)
    end

    vim.notify(message, vim.log.levels.INFO)
    ui.open_result(path)
end

return M
