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

toggle-git-on-ps1() {
    value=$(git config --global --get oh-my-zsh.hide-status)

    if [[ -z $value ]] || [[ $value == '0' ]]; then swapped=1 else swapped=0 fi

    git config --global --replace-all oh-my-zsh.hide-status $swapped
}