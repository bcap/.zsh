source-if-exists() {
    if [[ -f $1 ]]; then
        source $@
    fi
}

run-if-exists() {
    if [[ $# > 0 ]]; then
        if [[ -f $1 ]] || whence $1 N; then
            $@
        else
            return 128
        fi
    else
        return 1
    fi
}

sync-zsh() { rsync -av ~/.zsh ~/.zshrc "${1}:" }

ssh-with-sync() { sync-zsh $1 && ssh $1 }
