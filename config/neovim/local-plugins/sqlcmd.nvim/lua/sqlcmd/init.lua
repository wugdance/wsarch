--- Execute SQL through sqlcmd and render results in Neovim.

local query = require("sqlcmd.query")
local runner = require("sqlcmd.runner")

local M = {}

local config = nil

local function resolve_config(opts)
    opts = opts or {}

    if not opts.server then
        error("sqlcmd.nvim: opts.server is required")
    end
    if not opts.database then
        error("sqlcmd.nvim: opts.database is required")
    end

    return {
        server = opts.server,
        database = opts.database,
        trust_cert = opts.trust_cert == nil or opts.trust_cert,
        max_rows = opts.max_rows or 5000,
        mdformat_threshold = opts.mdformat_threshold == nil and 1000
            or opts.mdformat_threshold,
        output_dir = opts.output_dir
            or vim.fn.stdpath("cache") .. "/sqlcmd_output",
    }
end

--- Configure sqlcmd.
---@param opts table?
function M.setup(opts)
    config = resolve_config(opts)
end

--- Execute SQL from a named source.
---@param source string
function M.execute_sql(source)
    local ok, err = pcall(function()
        if not config then
            error("sqlcmd is not configured")
        end

        local sql = query.get_text(source)
        if not sql then
            vim.notify("No SQL text to execute.", vim.log.levels.WARN)
            return
        end

        runner.run(sql, config)
    end)

    if not ok then
        vim.notify(
            "SQL execution error: " .. tostring(err),
            vim.log.levels.ERROR
        )
    end
end

--- Execute the most recent visual selection.
---@param start_line integer
---@param end_line integer
---@param start_col? integer
---@param end_col? integer
function M.execute_sql_visual(start_line, end_line, start_col, end_col)
    local ok, err = pcall(function()
        if not config then
            error("sqlcmd is not configured")
        end

        local sql =
            query.get_text("visual", start_line, end_line, start_col, end_col)
        if not sql then
            vim.notify("No SQL text to execute.", vim.log.levels.WARN)
            return
        end

        runner.run(sql, config)
    end)

    if not ok then
        vim.notify(
            "SQL execution error: " .. tostring(err),
            vim.log.levels.ERROR
        )
    end
end

--- Execute the visual selection recorded in Neovim marks.
function M.execute_sql_from_marks()
    local mode = vim.fn.visualmode()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    if start_line == 0 or end_line == 0 then
        vim.notify("No visual selection detected.", vim.log.levels.WARN)
        return
    end

    if mode == "v" then
        local _, srow, scol = unpack(vim.fn.getpos("'<"))
        local _, erow, ecol = unpack(vim.fn.getpos("'>"))
        M.execute_sql_visual(start_line, end_line, scol - 1, ecol)
    else
        M.execute_sql_visual(start_line, end_line)
    end
end

--- Stop the currently running SQL query.
function M.stop_query()
    runner.stop_query()
end

return M
