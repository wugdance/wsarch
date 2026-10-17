function jit {
    base_url="https://jit.o3.ru/browse/"
    task=$(echo $(git branch --show-current) | cut -d '/' -f 2)
    explorer.exe "${base_url}${task}"
}

function vhtml {
    # If no argument is provided, show a help message
    if [ -z "$1" ]; then
        echo "Usage: open <file-path>"
        return 1
    fi

    # Convert the path using wslpath and open with PowerShell
    powershell.exe -Command "Start-Process '$(wslpath -w "$1")'"
}

# nvm lazy-loader: node/npm/npx/yarn/pnpm/nvm source nvm only on first use
__load_nvm() {
    unset -f node npm npx yarn pnpm nvm pi
    source /usr/share/nvm/init-nvm.sh
}
for __nvm_cmd in node npm npx yarn pnpm nvm pi; do
    eval "$__nvm_cmd() { __load_nvm; command $__nvm_cmd \"\$@\"; }"
done
unset __nvm_cmd


function glab-ci {
    local sha url

    sha=$(git rev-parse HEAD) || return 1

    url=$(glab ci list \
        --sha "$sha" \
        --output json \
        --jq '.[0].web_url') || {
        echo "Failed to find GitLab pipeline for commit $sha" >&2
        return 1
    }

    if [[ -z "$url" || "$url" == "null" ]]; then
        echo "No GitLab pipeline found for commit $sha" >&2
        return 1
    fi

    explorer.exe "$url" >/dev/null 2>&1 || true
}

# Review changed files with fzf/delta/nvim.
#
# Usage:
#   fzd                       # like plain `git diff`, plus untracked files
#   fzd HEAD                  # working tree vs HEAD
#   fzd master..HEAD          # committed branch changes only
#   fzd main...HEAD           # committed changes from merge-base
#   fzd origin/main           # working tree vs origin/main
#
# Keys:
#   Normal mode: <j/k> move, <ctrl-d>/<ctrl-u> delta page, <enter> delta, 
#                <ctrl-e> nvim, <q> quit
#   Insert mode: <i> enters, <esc> returns to normal mode, <enter> accepts
function fzd {
    local -a diff_args=("$@")
    local diff_args_str diff_cmd preview status status_lines
    local -a header_args=()

    diff_args_str=""
    local arg
    for arg in "${diff_args[@]}"; do
        diff_args_str+=" $(printf '%q' "$arg")"
    done

    # With no arguments this behaves like plain `git diff`: it reviews the
    # working tree against the index. Any arguments are passed to `git diff`.
    diff_cmd='if git ls-files --error-unmatch -- {} >/dev/null 2>&1; then git diff --color=always --diff-algorithm=histogram --find-renames'"${diff_args_str}"' -- {}; else git diff --no-index --color=always -- /dev/null {}; fi'
    preview="$diff_cmd | delta --width=\"\$FZF_PREVIEW_COLUMNS\" --paging=never"

    status=$(git status --short --branch --untracked-files=no | sed -n '1p')
    status_lines=$(wc -l <<<"$status")

    if [[ -n "$status" ]]; then
        header_args=(--header-lines="$status_lines" --header-lines-border=line)
    fi

    FZD_DIFF_ARGS="$diff_args_str" fzf \
        --prompt 'normal > ' \
        --layout=reverse-list \
        "${header_args[@]}" \
        --preview "$preview" \
        --preview-window right:60%:wrap \
        --bind 'j:down,k:up,ctrl-d:preview-down+preview-down+preview-down+preview-down+preview-down,ctrl-u:preview-up+preview-up+preview-up+preview-up+preview-up,q:abort' \
        --bind 'i:unbind(j,k,ctrl-d,ctrl-u,enter,ctrl-e,i,q)+change-prompt(insert> )' \
        --bind 'esc:rebind(j,k,ctrl-d,ctrl-u,enter,ctrl-e,i,q)+change-prompt(normal> )' \
        --bind "enter:execute($diff_cmd | delta)" \
        --bind 'ctrl-e:execute(test -f {} && nvim {} >/dev/tty </dev/tty || true)' \
        < <({ printf '%s\n' "$status"; git diff --name-only "${diff_args[@]}"; git ls-files --others --exclude-standard; })
}

