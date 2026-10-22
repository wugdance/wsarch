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
#                <ctrl-e> nvim (refresh diff/list on exit), <q> quit
#   Insert mode: <i> enters, <esc> returns to normal mode, <enter> accepts

# Emit fzd's candidate list. The first line is fzf's status header.
function __fzd_list {
    local -a diff_args=()

    if [[ -n "${FZD_DIFF_ARGS-}" ]]; then
        # FZD_DIFF_ARGS is built from printf %q in fzd below, so this is safe.
        eval "diff_args=(${FZD_DIFF_ARGS-})"
    fi

    git status --short --branch --untracked-files=no | sed -n '1p'
    git diff --name-only "${diff_args[@]}"
    git ls-files --others --exclude-standard
}
export -f __fzd_list

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
        --bind 'ctrl-e:execute(test -f {} && nvim {} >/dev/tty </dev/tty || true)+refresh-preview+reload-sync(__fzd_list)' \
        < <(__fzd_list)
}
