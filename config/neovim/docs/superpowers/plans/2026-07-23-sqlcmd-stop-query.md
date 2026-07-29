# SQL Query Stop Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Allow user to stop a running `sqlcmd` query via `<leader>qs` keymap

**Architecture:** Add `job_id` and `cancelled` module-level state to `init.lua`. The `on_exit` handler checks the `cancelled` flag: if partial output exists, writes it with a warning banner and opens the result window; otherwise just notifies cancellation. New `M.stop_query()` calls `vim.fn.jobstop()` which sends SIGTERM, triggering the exit handler naturally.

**Tech Stack:** Neovim Lua, vim.fn.jobstop

## Global Constraints

- No new files — only modify `lua/sqlcmd/init.lua` and `lua/config/keymaps.lua`
- Maintain backward compatibility: existing `<leader>q` users must update to `<leader>qr`
- Partial results must show a clear warning banner

---

### Task 1: Module state and stop query logic

**Files:**
- Modify: `lua/sqlcmd/init.lua`

**Interfaces:**
- Consumes: existing `running`, `timer`, `tmpfile`, `stdout_data`, `stderr_data`
- Produces: `M.stop_query()` — callable from keymaps

- [ ] **Step 1: Add module-level state**

Add after `local running = false`:

```lua
local job_id = nil
local cancelled = false
```

- [ ] **Step 2: Store `job_id` at module level in `run_query`**

Change `local job_id = vim.fn.jobstart(args, {` to `job_id = vim.fn.jobstart(args, {`.

- [ ] **Step 3: Reset `job_id` and `cancelled` in `on_exit`**

After `running = false` in the exit handler, add:

```lua
        job_id = nil
        local was_cancelled = cancelled
        cancelled = false
```

- [ ] **Step 4: Handle cancelled state in `on_exit`**

Before the `if exit_code ~= 0` block, add cancelled handling. If cancelled with partial data, write results with warning banner. If cancelled with no data, just notify.

- [ ] **Step 5: Add `M.stop_query()` function**

```lua
function M.stop_query()
    if not running or not job_id then
        vim.notify("No running SQL query to stop.", vim.log.levels.INFO)
        return
    end
    cancelled = true
    vim.fn.jobstop(job_id)
    vim.notify("SQL query stopping...", vim.log.levels.INFO)
end
```

---

### Task 2: Keymap changes

**Files:**
- Modify: `lua/config/keymaps.lua`

- [ ] **Step 1: Change `<leader>q` to `<leader>qr` for both normal and visual modes**
- [ ] **Step 2: Add `<leader>qs` bindings for `stop_query`**
