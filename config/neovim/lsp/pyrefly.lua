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
            analysis = {
                showHoverGoToLinks = false,
                -- If enable, you have to configure hl-groups.
                -- inlayHints = {
                --     callArgumentNames = "all",
                --     variableTypes = true,
                --     functionReturnTypes = true,
                --     pytestParameters = true,
                -- },
            },
            disabledLanguageServices = {
                semanticTokens = false,
            },
        },
    },
}
