#!/usr/bin/env bash
set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$REPO_ROOT/windows/.wezterm.lua"

fail() {
    echo "deploy-wezterm: $*" >&2
    exit 1
}

require_command() {
    command -v "$1" >/dev/null 2>&1 || fail "missing required command: $1"
}

for command in powershell.exe wslpath; do
    require_command "$command"
done

[[ -f "$SOURCE" ]] || fail "canonical config not found: $SOURCE"

# Prefer the Windows executable from PATH, but allow the normal install path.
if command -v wezterm.exe >/dev/null 2>&1; then
    WEZTERM_BIN="$(command -v wezterm.exe)"
elif [[ -x "/mnt/c/Program Files/WezTerm/wezterm.exe" ]]; then
    WEZTERM_BIN="/mnt/c/Program Files/WezTerm/wezterm.exe"
else
    fail "wezterm.exe not found"
fi

# Discover the real Windows user profile rather than assuming the Linux user
# has the same name as the Windows user.
WIN_PROFILE="$(powershell.exe -NoProfile -NonInteractive -Command 'Write-Output $env:USERPROFILE' | tr -d '\r')"
[[ -n "$WIN_PROFILE" ]] || fail "could not discover Windows USERPROFILE"

TARGET_DIR_UNIX="$(wslpath -u "$WIN_PROFILE")"
TARGET_UNIX="$TARGET_DIR_UNIX/.wezterm.lua"
TARGET_WIN="$(wslpath -w "$TARGET_UNIX")"
CANDIDATE_UNIX="$TARGET_DIR_UNIX/.wezterm.lua.candidate.$$"
CANDIDATE_WIN="$(wslpath -w "$CANDIDATE_UNIX")"

cleanup() {
    rm -f -- "$CANDIDATE_UNIX"
}
trap cleanup EXIT

[[ -d "$TARGET_DIR_UNIX" ]] || fail "Windows profile directory not found: $TARGET_DIR_UNIX"
[[ ! -L "$TARGET_UNIX" ]] || fail "refusing to overwrite symlink: $TARGET_UNIX"

# Validate before touching the active config.
cp -- "$SOURCE" "$CANDIDATE_UNIX"
"$WEZTERM_BIN" --config-file "$CANDIDATE_WIN" show-keys >/dev/null

# One-way deployment. The repo is authoritative; rollback is git history.
mv -- "$CANDIDATE_UNIX" "$TARGET_UNIX"

echo "deploy-wezterm: deployed $SOURCE -> $TARGET_UNIX"
