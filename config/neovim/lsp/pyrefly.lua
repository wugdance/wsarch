---@type vim.lsp.Config
return {
    cmd = {
        "pyrefly",
        "lsp",
    },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", ".git" },
    settings = {
        python = {
            pyrefly = {
                displayTypeErrors = "force-on",
            },
        },
    },
}
