return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', '.git' },
  settings = {
    -- Is it conflict with ty?
    -- lint = {
    --   enable = false,
    -- },
  },
}
