--- Helpers for working with Python projects.

local pytest = require("python.pytest")

local M = {}

local config = {
    pytest = {
        command = "uv run pytest",
        flags = { "-s", "-v" },
    },
}

--- Configure Python helpers.
---@param opts table?
function M.setup(opts)
    opts = opts or {}
    local pytest_options = opts.pytest or {}

    config = {
        pytest = {
            command = pytest_options.command or "uv run pytest",
            flags = pytest_options.flags or { "-s", "-v" },
        },
    }
end

--- Copy a pytest command for the current test or file.
function M.copy_pytest_command()
    pytest.copy_pytest_command(config.pytest)
end

return M
