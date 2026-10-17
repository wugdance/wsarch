--- Process lifecycle for sqlcmd queries.

local output = require("sqlcmd.output")

local M = {}

local running = false
local job_id = nil
local cancelled = false

local function build_args(config, tmpfile)
    local args = {
        "sqlcmd",
        "-S",
        config.server,
        "-E",
        "-d",
        config.database,
        "-I",
        "-s",
        "|",
        "-W",
        "-i",
        tmpfile,
    }

    if config.trust_cert then
        table.insert(args, "-C")
    end

    return args
end

local function fallback_capture(sql, tmpfile, sqlcmd_args)
    local rerun_tmp = vim.fn.tempname() .. ".sql"
    vim.fn.writefile(vim.split(sql, "\n", { plain = true }), rerun_tmp)

    local rerun_args = {}
    for _, arg in ipairs(sqlcmd_args) do
        if arg == tmpfile then
            table.insert(rerun_args, rerun_tmp)
        else
            table.insert(rerun_args, arg)
        end
    end

    local escaped = vim.iter(rerun_args)
        :map(function(arg)
            return vim.fn.shellescape(arg)
        end)
        :totable()
    local command = table.concat(escaped, " ") .. " 2>&1"
    local captured = vim.fn.system(command)

    pcall(os.remove, rerun_tmp)

    return captured
end

local function stop_progress(timer)
    timer:stop()
    timer:close()
    vim.api.nvim_echo({}, false, {})
end

--- Run a SQL query and display its result.
---@param sql string
---@param config table
function M.run(sql, config)
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
    local args = build_args(config, tmpfile)

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

    job_id = vim.fn.jobstart(args, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if data then
                vim.list_extend(stdout_data, data)
            end
        end,
        on_stderr = function(_, data)
            if data then
                vim.list_extend(stderr_data, data)
            end
        end,
        on_exit = function(_, exit_code)
            running = false
            job_id = nil
            local was_cancelled = cancelled
            cancelled = false
            local elapsed = (vim.uv.now() - start) / 1000

            stop_progress(timer)
            output.finish(config, {
                cancelled = was_cancelled,
                exit_code = exit_code,
                elapsed_seconds = elapsed,
                stdout = table.concat(stdout_data, "\n"),
                stderr = table.concat(stderr_data, "\n"),
                fallback = function()
                    return fallback_capture(sql, tmpfile, args)
                end,
            })

            pcall(os.remove, tmpfile)
        end,
    })

    if job_id <= 0 then
        running = false
        job_id = nil
        stop_progress(timer)
        pcall(os.remove, tmpfile)
        vim.notify("Failed to start sqlcmd process", vim.log.levels.ERROR)
    end
end

--- Stop the currently running SQL query.
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
