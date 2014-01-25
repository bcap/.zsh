#################################################################################################
###    Oh My Zsh    #############################################################################
#################################################################################################

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bcap"
plugins=(git vagrant)
source $ZSH/oh-my-zsh.sh


#################################################################################################
###    Options    ###############################################################################
#################################################################################################

# Save each line to the history file as it is executed
setopt INC_APPEND_HISTORY

# Don't save lines beginning with a space
setopt HIST_IGNORE_SPACE

# Save function definitions
unsetopt HIST_NO_FUNCTIONS

# Don't save duplicate history lines
setopt HIST_IGNORE_DUPS

# Don't find duplicate history lines
setopt HIST_FIND_NO_DUPS

# Tidy up the line when it is entered into the history by removing any excess blanks that mean nothing to the shell.
setopt HIST_REDUCE_BLANKS

# Don't share history between Z shells
unsetopt SHARE_HISTORY

# Save the time when the command was run, etc
setopt EXTENDED_HISTORY


#################################################################################################
###    Aliases    ###############################################################################
#################################################################################################

alias -g ...='../../'
alias -g ....='../../../'
alias -g .....='../../../../'
alias -g ......='../../../../../'

alias -g G=' | grep -i '
alias -g H=' | head -n 20 '
alias -g T=' | tail -n 20 '
alias -g L=' | less '
alias -g V=' | vim - '
alias -g F='find . G'
alias -g S=' | sort '
alias -g SN=' | sort -n '
alias -g N=' > /dev/null 2>&1 '

alias ls='ls --color=auto'
alias ll='ls -lhp'
alias la='ll -A'
alias l='la'

alias today='date +%Y-%m-%d'
alias now='date +%Y-%m-%dT%H:%M:%S'

alias gpg='gpg --personal-cipher-preferences AES256 --personal-compress-preferences ZLIB --armor'
alias encrypt-with-pass='gpg --symmetric'
alias encrypt-with-key='gpg --encrypt --sign --recipient polaco@gmail.com'
alias decrypt='gpg -d'

alias ack='ack-grep'

alias diff='diff -u'

alias treesize='du -sm * | sort -n'


#################################################################################################
###    Functions    #############################################################################
#################################################################################################

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

sync-zsh() { rsync -av ~/.oh-my-zsh ~/.zshrc "${1}:" }

ssh-with-sync() { sync-zsh $1 && ssh $1 }

source-if-exists /usr/local/bin/virtualenvwrapper.sh # ubuntu
source-if-exists /usr/local/share/python/virtualenvwrapper.sh # mac brew


#################################################################################################
###    Environment Vars    ######################################################################
#################################################################################################

# setting path and fpath in an array form (declared as lowercase variables)
fpath=(
    $HOME/.oh-my-zsh/zsh-completions
    $fpath
)

path=(
    $HOME/bin # personal scripts
    /usr/local/heroku/bin # heroku toolbelt
    /usr/local/opt/coreutils/libexec/gnubin # gnu coreutils on mac installed with brew
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /usr/sbin
    /bin
    /sbin
)

HISTSIZE=1000
SAVEHIST=1000000

# general vars
export SYSTEM="$(uname -s)"
export EDITOR="vim"
export VISUAL="subl --wait"
export PAGER="less"
export LESS="--chop-long-lines --raw-control-chars"
export MAVEN_OPTS="-Xmx256m -XX:MaxPermSize=256m"
export PIP_DOWNLOAD_CACHE=${HOME}/.pip/downloadcache
export WORKON_HOME=${HOME}/.virtualenvs # virtual env wrapper

# Linux specific
if [[ "$SYSTEM" == "Linux" ]]; then
    export LESS="$LESS --shift 0.3"
fi

# MAC specific
if [[ "$SYSTEM" == "Darwin" ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
fi

# aws stuff
AWS_CREDENTIALS_DIR=Dropbox/nix/aws/credentials
if [[ -d $AWS_CREDENTIALS_DIR ]]; then
    # personal var do help me out
    export AWS_CREDENTIALS_DIR

    # boto uses this
    export AWS_CREDENTIAL_FILE=$AWS_CREDENTIALS_DIR/aws-credentials-root

    # AWS tools uses this
    export AWS_ACCESS_KEY=$(grep AWSAccessKeyId $AWS_CREDENTIAL_FILE | cut -d '=' -f 2)
    export AWS_SECRET_KEY=$(grep AWSSecretKey $AWS_CREDENTIAL_FILE | cut -d '=' -f 2)
fi


#################################################################################################
###    Home Setup    ############################################################################
#################################################################################################

# Dropbox linking
DB_BASE_DIR=Dropbox/nix
if [[ -d $DB_BASE_DIR ]]; then
    link_db() { test ! -d $1 && ln -s $DB_BASE_DIR/$2 $1 }
    check_db_link() { test ! -h $1 && echo "WARNING: $1 should be linked to a subitem in $DB_BASE_DIR/$2" }
    link_db .gnupg gnupg
    link_db .pip pip
    link_db .ssh ssh
    link_db bin bin
    check_db_link .gitconfig git
fi
