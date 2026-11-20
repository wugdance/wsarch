# Neovim Config

Personal Neovim configuration. Keymaps, plugins, and editor behavior are defined
in Lua under `config/neovim/lua/`.

## Language

**Current path**:
The relative path from the working directory to the thing in front of you: a
file in a normal buffer, or the directory shown in an oil buffer. Falls back to
the absolute path when the target lies outside the working directory.
_Avoid_: buffer name
