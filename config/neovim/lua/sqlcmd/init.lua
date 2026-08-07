local format = require("sqlcmd.format")
local ui = require("sqlcmd.ui")

local M = {}
local running = false
local job_id = nil
local cancelled = false

M.server = vim.g.sqlcmd_server
    or error(
        "vim.g.sqlcmd_server is not set -- configure it in config/neovim/lua/config/local.lua"
    )
M.database = vim.g.sqlcmd_database
    or error(
        "vim.g.sqlcmd_database is not set -- configure it in config/neovim/lua/config/local.lua"
    )
M.trust_cert = true
M.max_rows = 5000
M.mdformat_threshold = 1000
M.error_path = vim.fn.stdpath("cache") .. "/sqlcmd_output/query-error.md"

local function get_sql_text(source, range_start, range_end, start_col, end_col)
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
            lines =
                vim.api.nvim_buf_get_lines(0, range_start - 1, range_end, false)
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

local function build_sqlcmd_args(sql, tmpfile)
    local args = {
        "sqlcmd",
        "-S",
        M.server,
        "-E",
        "-d",
        M.database,
        "-I",
        "-s",
        "|",
        "-W",
        "-i",
        tmpfile,
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
    local sql = opts.sql
    local sqlcmd_args = opts.sqlcmd_args

    local function clean_up()
        pcall(os.remove, tmpfile)
    end

    local function write_error(data)
        vim.fn.mkdir(vim.fs.dirname(M.error_path), "p")
        local f = io.open(M.error_path, "w")
        if f then
            f:write(data)
            f:close()
        end
        ui.open_result(M.error_path)
    end

    local function fallback_capture()
        local rerun_tmp = vim.fn.tempname() .. ".sql"
        vim.fn.writefile(vim.split(sql, "\n", { plain = true }), rerun_tmp)

        local rerun_args = {}
        for _, a in ipairs(sqlcmd_args) do
            if a == tmpfile then
                table.insert(rerun_args, rerun_tmp)
            else
                table.insert(rerun_args, a)
            end
        end

        local escaped = vim
            .iter(rerun_args)
            :map(function(a)
                return vim.fn.shellescape(a)
            end)
            :totable()
        local cmd = table.concat(escaped, " ") .. " 2>&1"
        local output = vim.fn.system(cmd)

        pcall(os.remove, rerun_tmp)
        return output
    end

    return function(_, exit_code, _)
        running = false
        job_id = nil
        local was_cancelled = cancelled
        cancelled = false
        local elapsed = (vim.uv.now() - start) / 1000

        timer:stop()
        timer:close()
        vim.api.nvim_echo({}, false, {})

        if was_cancelled then
            if #stdout_data > 0 then
                local raw = table.concat(stdout_data, "\n")
                local cancelled_path = vim.fn.stdpath("cache")
                    .. "/sqlcmd_output/query-cancelled.md"
                vim.fn.mkdir(vim.fs.dirname(cancelled_path), "p")

                local row_count =
                    format.write_stream(raw, cancelled_path, M.max_rows)

                if row_count and row_count > 0 then
                    local content = vim.fn.readfile(cancelled_path)
                    table.insert(content, 1, "")
                    table.insert(
                        content,
                        1,
                        "> **Query cancelled** — results may be incomplete"
                    )
                    vim.fn.writefile(content, cancelled_path)

                    ui.open_result(cancelled_path)
                    vim.notify(
                        "SQL query cancelled — partial results shown",
                        vim.log.levels.WARN
                    )
                else
                    vim.notify("SQL query cancelled.", vim.log.levels.WARN)
                end
            else
                vim.notify("SQL query cancelled.", vim.log.levels.WARN)
            end
            clean_up()
            return
        end

        if exit_code ~= 0 then
            local raw = table.concat(stdout_data, "\n")
            local err = table.concat(stderr_data, "\n")
            if raw == "" and err == "" then
                raw = fallback_capture()
            elseif raw == "" and err ~= "" then
                raw = err
            end
            write_error(raw)
            local msg = string.format(
                "SQL query failed (%.1fs): exited with code %d — see output buffer",
                elapsed,
                exit_code
            )
            vim.notify(msg, vim.log.levels.ERROR)
            clean_up()
            return
        end

        local raw = table.concat(stdout_data, "\n")
        local out_path = vim.fn.stdpath("cache")
            .. "/sqlcmd_output/query-output.md"
        vim.fn.mkdir(vim.fs.dirname(out_path), "p")

        vim.api.nvim_echo({
            { "sqlcmd: writing results... ", "None" },
        }, false, {})

        local row_count, total_found =
            format.write_stream(raw, out_path, M.max_rows)

        if row_count == nil then
            vim.notify(
                "Failed to write results: " .. tostring(total_found),
                vim.log.levels.ERROR
            )
            clean_up()
            return
        end

        if row_count == 0 then
            if exit_code == 0 then
                local raw = table.concat(stdout_data, "\n")
                local filtered = raw:gsub("^%s*(.-)%s*$", "%1")
                if filtered ~= "" then
                    vim.fn.mkdir(vim.fs.dirname(out_path), "p")
                    local f = io.open(out_path, "w")
                    if f then
                        f:write(raw)
                        f:close()
                    end
                    ui.open_result(out_path)
                    vim.notify(
                        "Query executed — no table data",
                        vim.log.levels.INFO
                    )
                else
                    vim.notify(
                        "Query executed (no output)",
                        vim.log.levels.INFO
                    )
                end
            else
                local captured = fallback_capture()
                write_error(
                    captured ~= "" and captured or "Query failed with no output"
                )
                vim.notify(
                    "Query failed — see output buffer",
                    vim.log.levels.ERROR
                )
            end
            clean_up()
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
        clean_up()
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
        sql = sql,
        sqlcmd_args = args,
    })

    job_id = vim.fn.jobstart(args, {
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
        vim.notify(
            "SQL execution error: " .. tostring(err),
            vim.log.levels.ERROR
        )
    end
end

function M.execute_sql_visual(start_line, end_line, start_col, end_col)
    local ok, err = pcall(function()
        local sql = get_sql_text("visual", start_line, end_line, start_col, end_col)
        if not sql then
            vim.notify("No SQL text to execute.", vim.log.levels.WARN)
            return
        end
        run_query(sql)
    end)
    if not ok then
        vim.notify(
            "SQL execution error: " .. tostring(err),
            vim.log.levels.ERROR
        )
    end
end

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

function M.stop_query()
    if not running or not job_id then
        vim.notify("No running SQL query to stop.", vim.log.levels.INFO)
        return
    end
    cancelled = true
    vim.fn.jobstop(job_id)
    vim.notify("SQL query stopping...", vim.log.levels.INFO)
end

return M
