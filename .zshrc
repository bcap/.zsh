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

# Linux specific
if [[ "$SYSTEM" == "Linux" ]]; then
    export LESS="$LESS --shift 0.3"
fi

# MAC specific
if [[ "$SYSTEM" == "Darwin" ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"

    # MAC brew specific
    if whence brew N; then
        path=($(brew --prefix coreutils)/libexec/gnubin $path) # Overwrite BSD like core utils (ls, sed, grep, etc) with GNU core utils
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
###    Misc Vars    #############################################################################
#################################################################################################

# Terminal output control (http://www.termsys.demon.co.uk/vtansi.htm)

TC='\e['

CLR_LINE_START="${TC}1K"
CLR_LINE_END="${TC}K"
CLR_LINE="${TC}2K"

RESET_LINE="${CLR_LINE}${TC}1000D"

# Colors

RCol="${TC}0m" # Reset Color

# Regular          Bold                Underline           High Intensity      BoldHigh Intensity   Background          High Intensity Backgrounds
Bla="${TC}0;30m";  BBla="${TC}1;30m";  UBla="${TC}4;30m";  IBla="${TC}0;90m";  BIBla="${TC}1;90m";  On_Bla="${TC}40m";  On_IBla="${TC}0;100m";
Red="${TC}0;31m";  BRed="${TC}1;31m";  URed="${TC}4;31m";  IRed="${TC}0;91m";  BIRed="${TC}1;91m";  On_Red="${TC}41m";  On_IRed="${TC}0;101m";
Gre="${TC}0;32m";  BGre="${TC}1;32m";  UGre="${TC}4;32m";  IGre="${TC}0;92m";  BIGre="${TC}1;92m";  On_Gre="${TC}42m";  On_IGre="${TC}0;102m";
Yel="${TC}0;33m";  BYel="${TC}1;33m";  UYel="${TC}4;33m";  IYel="${TC}0;93m";  BIYel="${TC}1;93m";  On_Yel="${TC}43m";  On_IYel="${TC}0;103m";
Blu="${TC}0;34m";  BBlu="${TC}1;34m";  UBlu="${TC}4;34m";  IBlu="${TC}0;94m";  BIBlu="${TC}1;94m";  On_Blu="${TC}44m";  On_IBlu="${TC}0;104m";
Pur="${TC}0;35m";  BPur="${TC}1;35m";  UPur="${TC}4;35m";  IPur="${TC}0;95m";  BIPur="${TC}1;95m";  On_Pur="${TC}45m";  On_IPur="${TC}0;105m";
Cya="${TC}0;36m";  BCya="${TC}1;36m";  UCya="${TC}4;36m";  ICya="${TC}0;96m";  BICya="${TC}1;96m";  On_Cya="${TC}46m";  On_ICya="${TC}0;106m";
Whi="${TC}0;37m";  BWhi="${TC}1;37m";  UWhi="${TC}4;37m";  IWhi="${TC}0;97m";  BIWhi="${TC}1;97m";  On_Whi="${TC}47m";  On_IWhi="${TC}0;107m";
