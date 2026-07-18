local format = require("sqlcmd.format")
local ui = require("sqlcmd.ui")

local M = {}
local running = false

M.server = vim.g.sqlcmd_server
    or error("vim.g.sqlcmd_server is not set -- configure it in config/neovim/lua/config/local.lua")
M.database = vim.g.sqlcmd_database
    or error("vim.g.sqlcmd_database is not set -- configure it in config/neovim/lua/config/local.lua")
M.trust_cert = true
M.max_rows = 5000
M.mdformat_threshold = 1000

local function get_sql_text(source, range_start, range_end)
    local lines

    if source == "buffer" then
        lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    elseif source == "visual" then
        lines = vim.api.nvim_buf_get_lines(0, range_start - 1, range_end, false)
    end

    if #lines == 0 or (#lines == 1 and lines[1] == "") then
        return nil
    end

    if lines[#lines] == "" then
        table.remove(lines)
    end

    return table.concat(lines, "\n")
end

local function build_sqlcmd_args(sql, tmpfile)
    local args = {
        "sqlcmd",
        "-S", M.server,
        "-E",
        "-d", M.database,
        "-s", "|",
        "-W",
        "-i", tmpfile,
    }
    if M.trust_cert then
        table.insert(args, "-C")
    end
    return args
end

local function should_format(total_found, row_count)
    if vim.fn.executable("mdformat") ~= 1 then
        return false
    end
    if M.mdformat_threshold == 0 then
        return true
    end
    return math.max(row_count, total_found) <= M.mdformat_threshold
end

local function create_exit_handler(opts)
    local timer = opts.timer
    local tmpfile = opts.tmpfile
    local start = opts.start
    local stdout_data = opts.stdout_data
    local stderr_data = opts.stderr_data

    return function(_, exit_code, _)
        running = false
        local elapsed = (vim.uv.now() - start) / 1000

        timer:stop()
        timer:close()
        vim.api.nvim_echo({}, false, {})
        pcall(os.remove, tmpfile)

        if exit_code ~= 0 then
            local msg = string.format(
                "SQL query failed (%.1fs): exited with code %d",
                elapsed,
                exit_code
            )
            if stderr_data and #stderr_data > 0 then
                local err_text = table
                    .concat(stderr_data, "\n")
                    :gsub("%s+$", "")
                    :gsub("\n", " ")
                msg = msg .. " " .. err_text
            end
            vim.notify(msg, vim.log.levels.ERROR)
            return
        end

        local raw = table.concat(stdout_data, "\n")
        local out_path = vim.fn.stdpath("cache")
            .. "/sqlcmd_output/query-output.md"
        vim.fn.mkdir(vim.fn.fnamemodify(out_path, ":h"), "p")

        vim.api.nvim_echo({
            { "sqlcmd: writing results... ", "None" },
        }, false, {})

        local row_count, total_found = format.write_stream(
            raw,
            out_path,
            M.max_rows
        )

        if row_count == nil then
            vim.notify(
                "Failed to write results: " .. tostring(total_found),
                vim.log.levels.ERROR
            )
            return
        end

        if row_count == 0 then
            if stderr_data and #stderr_data > 0 then
                local err_text = table
                    .concat(stderr_data, "\n")
                    :gsub("%s+$", "")
                    :gsub("\n", " ")
                vim.notify(
                    "sqlcmd reported: " .. err_text,
                    vim.log.levels.ERROR
                )
            else
                vim.notify(
                    "No data returned from query.",
                    vim.log.levels.WARN
                )
            end
            return
        end

        if total_found > row_count then
            local f = io.open(out_path, "a")
            if f then
                f:write(
                    string.format(
                        "\n---\n\n_Showing first %d of %d rows_\n",
                        row_count,
                        total_found
                    )
                )
                f:close()
            end
        end

        if should_format(total_found, row_count) then
            vim.fn.system({ "mdformat", out_path })
        elseif
            total_found > M.mdformat_threshold
            and vim.fn.executable("mdformat") == 1
        then
            vim.notify(
                string.format(
                    "Skipped mdformat: %d rows exceeds threshold of %d",
                    total_found,
                    M.mdformat_threshold
                ),
                vim.log.levels.INFO
            )
        end

        local msg = string.format(
            "SQL query completed in %.1fs (%d rows)",
            elapsed,
            row_count
        )
        if total_found > row_count then
            msg = msg .. string.format(", truncated from %d", total_found)
        end
        vim.notify(msg, vim.log.levels.INFO)

        ui.open_result(out_path)
    end
end

local function run_query(sql)
    if running then
        vim.notify("SQL query already in progress.", vim.log.levels.WARN)
        return
    end

    if vim.fn.executable("sqlcmd") ~= 1 then
        vim.notify("sqlcmd not found in PATH", vim.log.levels.ERROR)
        return
    end

    running = true

    local tmpfile = vim.fn.tempname() .. ".sql"
    vim.fn.writefile(vim.split(sql, "\n", { plain = true }), tmpfile)

    local args = build_sqlcmd_args(sql, tmpfile)

    local start = vim.uv.now()
    vim.notify("SQL query pending...", vim.log.levels.INFO)

    local stdout_data = {}
    local stderr_data = {}
    local timer = vim.uv.new_timer()

    timer:start(
        100,
        100,
        vim.schedule_wrap(function()
            local elapsed = (vim.uv.now() - start) / 1000
            vim.api.nvim_echo({
                { "sqlcmd: running... ", "None" },
                { string.format("%.1fs", elapsed), "Title" },
                { " ", "None" },
            }, false, {})
        end)
    )

    local on_exit = create_exit_handler({
        timer = timer,
        tmpfile = tmpfile,
        start = start,
        stdout_data = stdout_data,
        stderr_data = stderr_data,
    })

    local job_id = vim.fn.jobstart(args, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.list_extend(stdout_data, data)
            end
        end,
        on_stderr = function(_, data, _)
            if data then
                vim.list_extend(stderr_data, data)
            end
        end,
        on_exit = on_exit,
    })

    if job_id <= 0 then
        running = false
        timer:stop()
        timer:close()
        vim.api.nvim_echo({}, false, {})
        pcall(os.remove, tmpfile)
        vim.notify("Failed to start sqlcmd process", vim.log.levels.ERROR)
    end
end

function M.execute_sql(source)
    local ok, err = pcall(function()
        local sql = get_sql_text(source)
        if not sql then
            vim.notify("No SQL text to execute.", vim.log.levels.WARN)
            return
        end
        run_query(sql)
    end)
    if not ok then
        vim.notify("SQL execution error: " .. tostring(err), vim.log.levels.ERROR)
    end
end

function M.execute_sql_visual(start_line, end_line)
    local ok, err = pcall(function()
        local sql = get_sql_text("visual", start_line, end_line)
        if not sql then
            vim.notify("No SQL text to execute.", vim.log.levels.WARN)
            return
        end
        run_query(sql)
    end)
    if not ok then
        vim.notify("SQL execution error: " .. tostring(err), vim.log.levels.ERROR)
    end
end

function M.execute_sql_from_marks()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    if start_line == 0 or end_line == 0 then
        vim.notify("No visual selection detected.", vim.log.levels.WARN)
        return
    end
    M.execute_sql_visual(start_line, end_line)
end

return M
