return {
    cmd = { "ruff", "server" },
    filetypes = { "python" },
    root_markers = { "pyproject.toml", ".git" },
    settings = {
        lineLength = 79,
    },
    capabilities = {
        general = {
            -- pyright uses utf-16, and ruff uses utf-8 by default.
            -- To avoid 'multiple different client offset_encodings ...',
            -- we tell ruff to use 'utf-16' only
            -- https://github.com/astral-sh/ruff/issues/14483
            positionEncodings = { "utf-16" },
        },
    },
}
