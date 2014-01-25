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

plugins=(git vagrant)

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

# Dropbox linking
DB_BASE_DIR=Dropbox/nix
if [[ -d $DB_BASE_DIR ]]; then
    link_db() { [[ ! -d $1 ]] && ln -s $DB_BASE_DIR/$2 $1 }
    check_db_link() { [[ ! -h $1 ]] && echo "WARNING: $1 should be linked to a subitem in $DB_BASE_DIR/$2" }
    link_db .gnupg gnupg
    link_db .pip pip
    link_db .ssh ssh
    link_db bin bin
    check_db_link .gitconfig git
fi

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
###    Terminal specials    #####################################################################
#################################################################################################


# Terminal output control (http://www.termsys.demon.co.uk/vtansi.htm)
tc='\e['

# Colors and styles (based on https://github.com/demure/dotfiles/blob/master/subbash/prompt)

bold="${tc}1m"        # Bold text only, keep colors
underline="${tc}4m"   # Underline text only, keep colors
inverse="${tc}7m"     # Inverse: swap background and foreground colors
regular="${tc}22;24m" # Regular text only, keep colors
nofg="${tc}39m"       # Regular foreground coloring
nobg="${tc}49m"       # Regular background coloring
nostyle="${tc}0m"     # Reset all coloring and style

# Basic            High Intensity      Background           High Intensity Background
black="${tc}30m";  iblack="${tc}90m";  onblack="${tc}40m";  oniblack="${tc}100m";
red="${tc}31m";    ired="${tc}91m";    onred="${tc}41m";    onired="${tc}101m";
green="${tc}32m";  igreen="${tc}92m";  ongreen="${tc}42m";  onigreen="${tc}102m";
yellow="${tc}33m"; iyellow="${tc}93m"; onyellow="${tc}43m"; oniyellow="${tc}103m";
blue="${tc}34m";   iblue="${tc}94m";   onblue="${tc}44m";   oniblue="${tc}104m";
purple="${tc}35m"; ipurple="${tc}95m"; onpurple="${tc}45m"; onipurple="${tc}105m";
cyan="${tc}36m";   icyan="${tc}96m";   oncyan="${tc}46m";   onicyan="${tc}106m";
white="${tc}37m";  iwhite="${tc}97m";  onwhite="${tc}47m";  oniwhite="${tc}107m";

color_pallete() {
    (
    local text="${1=Colouring}"
    local padding=${#text}

    local colors="black red green yellow blue purple cyan white"
    local styles="bold underline"

    # ${(s: :)var} splits var into lines where a ' ' (space) is found
    # ${(r:number:)var} makes the output into number columns, creating a padding to the right if necessary
    # ${(l:number:)var} makes the output into number columns, creating a padding to the left if necessary

    echo "${bold}${white}Color pallete${nostyle}"
    echo
    echo "The name of the columns/rows are the name of the actual variables"
    echo "For example, to print ${bold}${red}${onwhite}this text${nostyle}, use:" '${bold}${red}${onwhite}this text${nostyle}'
    echo
    echo "A color with the 'i' prefix means 'intense', normally a brighter color. For example: ${green}green${nostyle} and ${igreen}igreen${nostyle}"
    echo
    echo "Supported styles are: "
    echo "  bold: ${bold}Some nice text${nostyle}"
    echo "  underline: ${underline}Some nice text${nostyle}"
    echo "  inverse (swaps background and foreground colors): ${inverse}Some nice text${nostyle}"
    echo "  regular (keep colors but make text regular, removing the underline or bold): ${iblue}${underline}Some nice${regular} text${nostyle}"
    echo "  nofg (remove foreground color): ${underline}${iblue}Some nice${nofg} text${nostyle}"
    echo "  nobg (remove background color): ${underline}${white}${ongreen}Some nice${nobg} text${nostyle}"
    echo "  nostyle (resets everything, removing any color or styling): ${underline}${white}${ongreen}Some nice${nostyle} text"
    echo
    echo "Press -R to toggle between color codes and actual coloring"
    echo

    # header
    for column in style color; do
        echo -n "${(r:9:)column} "
    done
    column=regular
    echo -n "${(r:${padding}:)column} "
    for column in ${(s: :)colors}; do
        for bgtype in on oni; do
            final_column=$bgtype$column
            echo -n "${(r:${padding}:)final_column} "
        done
    done
    echo

    # data
    for style in "" ${(s: :)styles}; do
        for color in ${(s: :)colors} ; do
            for fgtype in "" i; do
                local final_color=$fgtype$color
                echo -n "${(l:9:)style} ${(r:9:)final_color} "
                echo -n "${(P)style}${(P)final_color}${(r:${padding}:)text}${nostyle} "
                for background in ${(s: :)colors}; do
                    for bgtype in on oni; do
                        local final_background=$bgtype$background
                        echo -n "${(P)style}${(P)final_color}${(P)final_background}${(r:${padding}:)text}${nostyle} "
                    done
                done
                echo ${nostyle}
            done
        done
    done
    ) | less -R -S
}
