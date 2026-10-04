-- Open tmux scrollback captured as ANSI text in a searchable Neovim buffer.
local M = {}

local transport_buffer_name = "wsarch-scrollback"

local function is_safe_empty_buffer(bufnr)
    if vim.api.nvim_buf_get_name(bufnr) ~= "" then
        return false
    end

    if vim.bo[bufnr].buftype ~= "" then
        return false
    end

    if vim.bo[bufnr].modified then
        return false
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    return #lines == 1 and lines[1] == ""
end

local function was_opened_for_viewer()
    return vim.tbl_contains(vim.v.argv, "+TmuxScrollback")
end

local function prepare_viewer_buffer(bufnr)
    -- Reuse Neovim's initial empty buffer when this command is run as
    -- `nvim +TmuxScrollback`. Never reuse a real file buffer.
    if not is_safe_empty_buffer(bufnr) then
        bufnr = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_set_current_buf(bufnr)
    end

    vim.bo[bufnr].buftype = "nofile"
    vim.bo[bufnr].bufhidden = "hide"
    vim.bo[bufnr].buflisted = false
    vim.bo[bufnr].swapfile = false
    vim.bo[bufnr].undofile = false
    vim.bo[bufnr].modifiable = true

    vim.api.nvim_set_option_value("wrap", false, { win = 0, scope = "local" })
    vim.api.nvim_set_option_value("colorcolumn", "", { win = 0, scope = "local" })
    vim.api.nvim_set_option_value("spell", false, { win = 0, scope = "local" })
    vim.api.nvim_set_option_value("list", false, { win = 0, scope = "local" })
    vim.diagnostic.enable(false, { bufnr = bufnr })

    return bufnr
end

local function close_viewer(bufnr)
    -- In the normal tmux workflow this Neovim instance contains only the
    -- scrollback viewer, so quitting exits Neovim and closes the tmux window.
    if #vim.api.nvim_list_wins() == 1 then
        vim.cmd("quit!")
        return
    end

    vim.cmd("close")

    -- If the same scratch buffer is shown in another window, keep it. Once no
    -- window displays it, delete it so discarded edits do not stay in memory.
    local is_visible = vim.iter(vim.api.nvim_list_wins()):any(function(win)
        return vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == bufnr
    end)

    if not is_visible then
        vim.api.nvim_buf_delete(bufnr, { force = true })
    end
end

function M.setup()
    vim.api.nvim_create_user_command("TmuxScrollback", function()
        if not vim.env.TMUX then
            vim.notify("TmuxScrollback can only be used inside tmux.", vim.log.levels.WARN)
            return
        end

        local output = vim.fn.system({ "tmux", "show-buffer", "-b", transport_buffer_name })
        if vim.v.shell_error ~= 0 then
            vim.notify(
                "Could not read tmux scrollback:\n" .. vim.trim(output),
                vim.log.levels.ERROR
            )

            -- If tmux opened a fresh Neovim instance only to show this viewer,
            -- close it instead of leaving an empty [No Name] window behind.
            if was_opened_for_viewer() and is_safe_empty_buffer(0) then
                vim.defer_fn(function()
                    if is_safe_empty_buffer(0) then
                        vim.cmd("quit!")
                    end
                end, 2000)
            end

            return
        end

        local baleia = require("baleia").setup({
            async = false,
            chunk_size = 500,
            strip_ansi_codes = true,
        })

        local lines = vim.split(output, "\n", { plain = true })
        if lines[#lines] == "" then
            table.remove(lines)
        end
        if #lines == 0 then
            lines = { "" }
        end

        local bufnr = prepare_viewer_buffer(vim.api.nvim_get_current_buf())
        baleia.buf_set_lines(bufnr, 0, -1, false, lines)
        vim.bo[bufnr].modified = false

        -- Position at the true end once, then center it.
        vim.api.nvim_win_set_cursor(0, { vim.api.nvim_buf_line_count(bufnr), 0 })
        vim.cmd("normal! zz")

        vim.keymap.set("n", "q", function()
            close_viewer(bufnr)
        end, {
            buffer = bufnr,
            desc = "Close tmux scrollback viewer.",
            silent = true,
            nowait = true,
        })

        -- The tmux buffer is only a transport; Neovim now owns the copy.
        vim.fn.system({ "tmux", "delete-buffer", "-b", transport_buffer_name })
    end, {
        desc = "Open tmux scrollback with ANSI colors.",
    })
end

return M
