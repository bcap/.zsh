#################################################################################################
###    Oh My Zsh Configs    #####################################################################
#################################################################################################

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bcap"

plugins=(git)

# Enabling oh-my-zsh
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
alias -g NS=' | sort -n '
alias -g N=' > /dev/null 2>&1 '

alias ls='ls --color=auto'
alias ll='ls -lhp'
alias la='ll -A'

alias today='date +%Y%m%d'
alias now='date +%Y%m%d-%H%M%S'

alias gpg='gpg --personal-cipher-preferences AES256 --personal-compress-preferences ZLIB --armor'
alias encrypt-with-pass='gpg --symmetric'
alias encrypt-with-key='gpg --encrypt --sign --recipient polaco@gmail.com'
alias decrypt='gpg -d'

alias ack='ack-grep'

alias diff='diff -u'

alias treesize='du -sm * | sort -n'

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
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /usr/sbin
    /bin
    /sbin
)

HISTSIZE=10000
SAVEHIST=10000

# general vars
export SYSTEM="$(uname -s)"
export EDITOR="vim"
export VISUAL="subl --wait"
export PAGER="less"
export LESS="--chop-long-lines --raw-control-chars"
export MAVEN_OPTS="-Xmx256m -XX:MaxPermSize=256m"
export PIP_DOWNLOAD_CACHE=${HOME}/.pip/downloadcache

# Linux specific
if [[ "$SYSTEM" == "Linux" ]]; then
    export LESS="$LESS --shift 0.3"
fi

# MAC specific
if [[ "$SYSTEM" == "Darwin" ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"

    # MAC brew specific
    if whence brew N; then
        # Overwrite BSD like core utils (ls, sed, grep, etc) with GNU core utils
        path=($(brew --prefix coreutils)/libexec/gnubin $path)
    fi
fi

# aws stuff
AWS_CREDENTIALS_DIR=$HOME/Dropbox/nix/aws
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
###    Functions    #############################################################################
#################################################################################################

source_if_exists() {
    if [[ -f $1 ]]; then
        source $@
    fi
}

run_if_exists() {
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

source_if_exists /usr/local/bin/virtualenvwrapper.sh


#################################################################################################
###    Misc    ##################################################################################
#################################################################################################

# Terminal output control (http://www.termsys.demon.co.uk/vtansi.htm)

TC='\e['

CLR_LINE_START="${TC}1K"
CLR_LINE_END="${TC}K"
CLR_LINE="${TC}2K"

# Hope no terminal is greater than 1k columns
RESET_LINE="${CLR_LINE}${TC}1000D"

# Colors and styles (based on https://github.com/demure/dotfiles/blob/master/subbash/prompt)

Bold="${TC}1m"    # Bold text only, keep colors
Undr="${TC}4m"    # Underline text only, keep colors
Inv="${TC}7m"     # Inverse: swap background and foreground colors
Reg="${TC}22;24m" # Regular text only, keep colors
RegF="${TC}39m"   # Regular foreground coloring
RegB="${TC}49m"   # Regular background coloring
Rst="${TC}0m"     # Reset all coloring and style

# Basic            High Intensity      Background           High Intensity Background
Black="${TC}30m";  IBlack="${TC}90m";  OnBlack="${TC}40m";  OnIBlack="${TC}100m";
Red="${TC}31m";    IRed="${TC}91m";    OnRed="${TC}41m";    OnIRed="${TC}101m";
Green="${TC}32m";  IGreen="${TC}92m";  OnGreen="${TC}42m";  OnIGreen="${TC}102m";
Yellow="${TC}33m"; IYellow="${TC}93m"; OnYellow="${TC}43m"; OnIYellow="${TC}103m";
Blue="${TC}34m";   IBlue="${TC}94m";   OnBlue="${TC}44m";   OnIBlue="${TC}104m";
Purple="${TC}35m"; IPurple="${TC}95m"; OnPurple="${TC}45m"; OnIPurple="${TC}105m";
Cyan="${TC}36m";   ICyan="${TC}96m";   OnCyan="${TC}46m";   OnICyan="${TC}106m";
White="${TC}37m";  IWhite="${TC}97m";  OnWhite="${TC}47m";  OnIWhite="${TC}107m";
