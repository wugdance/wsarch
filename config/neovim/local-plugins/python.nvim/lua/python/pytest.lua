--- Generate and copy pytest commands for the current buffer.

local M = {}

--- Quote a value for use in a POSIX-style shell command.
local function shell_quote(value)
    return "'" .. value:gsub("'", [['\'']]) .. "'"
end

--- Return the textual name of a Tree-sitter definition node.
local function definition_name(node, bufnr)
    local name_node = node:field("name")[1]
    if not name_node then
        return nil
    end

    local ok, name = pcall(vim.treesitter.get_node_text, name_node, bufnr)
    if not ok then
        return nil
    end

    return name
end

--- Return whether a filename uses pytest's standard test file names.
local function is_test_file(path)
    local filename = vim.fs.basename(path)

    return filename:match("^test_.*%.py$") ~= nil
        or filename:match("^.*_test%.py$") ~= nil
end

--- Build a file-level pytest command.
local function file_command(options, path)
    local parts = { options.command, shell_quote(path) }
    vim.list_extend(parts, options.flags)

    return table.concat(parts, " ")
end

--- Build a pytest command for an explicit node ID.
local function node_command(options, path, node_id)
    local target = ("%s::%s"):format(path, node_id)
    local parts = { options.command, shell_quote(target) }
    vim.list_extend(parts, options.flags)

    return table.concat(parts, " ")
end

--- Return the Python Tree-sitter root node, if the parser is available.
local function python_tree_root(bufnr)
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "python")
    if not ok or not parser then
        return nil
    end

    local parse_ok, trees = pcall(parser.parse, parser)
    if not parse_ok or type(trees) ~= "table" or #trees == 0 then
        return nil
    end

    return trees[1]:root()
end

--- Return whether a Tree-sitter function is a collectable pytest test.
---
--- Nested functions are not collected by pytest, even when they use the
--- standard `test_` naming convention.
local function is_collectable_test_function(node, bufnr)
    local name = definition_name(node, bufnr)
    if not name or name:match("^test_") == nil then
        return false
    end

    local parent = node:parent()
    while parent and parent:type() ~= "module" do
        if parent:type() == "function_definition" then
            return false
        end
        parent = parent:parent()
    end

    return true
end

--- Find the test function enclosing the cursor.
---
--- Non-test functions are skipped so that a cursor inside a local helper
--- still resolves to the enclosing test.
local function test_function_at_cursor(bufnr, root)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row = cursor[1] - 1
    local col = cursor[2]
    local node = root:named_descendant_for_range(row, col, row, col)

    while node do
        if node:type() == "decorated_definition" then
            for child in node:iter_children() do
                if child:type() == "function_definition" then
                    if is_collectable_test_function(child, bufnr) then
                        return child
                    end

                    -- Move past the decorated wrapper before searching
                    -- outwards; otherwise the same wrapper is visited twice.
                    node = node:parent()
                    break
                end
            end

            if not node then
                break
            end
        elseif node:type() == "function_definition" then
            if is_collectable_test_function(node, bufnr) then
                return node
            end
        end

        node = node:parent()
    end

    return nil
end

--- Build the pytest node ID for a test function and its enclosing classes.
local function pytest_node_id(function_node, bufnr)
    local class_names = {}
    local node = function_node:parent()

    while node do
        if node:type() == "class_definition" then
            local class_name = definition_name(node, bufnr)
            if not class_name or class_name:match("^Test") == nil then
                return nil
            end

            table.insert(class_names, 1, class_name)
        end

        node = node:parent()
    end

    local function_name = definition_name(function_node, bufnr)
    if not function_name then
        return nil
    end

    table.insert(class_names, function_name)

    return table.concat(class_names, "::")
end

--- Build a pytest command for the current buffer.
---@param options table
function M.copy_pytest_command(options)
    local buffer = vim.api.nvim_get_current_buf()

    if vim.bo[buffer].filetype ~= "python" then
        vim.notify(
            "Pytest command is only available in Python buffers.",
            vim.log.levels.ERROR
        )
        return
    end

    local buffer_path = vim.api.nvim_buf_get_name(buffer)
    if buffer_path == "" then
        vim.notify("Buffer has no file path.", vim.log.levels.ERROR)
        return
    end

    local cwd = vim.uv.cwd()
    if not cwd or cwd == "" then
        vim.notify("Neovim has no working directory.", vim.log.levels.ERROR)
        return
    end

    local relative_path = vim.fs.relpath(cwd, buffer_path)
    if not relative_path then
        vim.notify(
            "Buffer path is outside the current working directory.",
            vim.log.levels.ERROR
        )
        return
    end

    if not is_test_file(relative_path) then
        vim.notify(
            "Buffer does not use a standard pytest test filename.",
            vim.log.levels.ERROR
        )
        return
    end

    local command = file_command(options, relative_path)

    local ok, root = pcall(python_tree_root, buffer)
    if ok and root then
        local function_node = test_function_at_cursor(buffer, root)
        local node_id = function_node and pytest_node_id(function_node, buffer)

        if node_id then
            command = node_command(options, relative_path, node_id)
        end
    end

    vim.fn.setreg("+", command)
    vim.notify("Copied: " .. command, vim.log.levels.INFO)
end

return M
