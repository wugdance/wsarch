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

