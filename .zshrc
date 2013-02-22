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

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

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
###    Variables    #############################################################################
#################################################################################################

HISTSIZE=10000
SAVEHIST=10000

export EDITOR=vim

alias ll='ls -lhp --color=auto'
alias la='ll -A'

# additional fpath
fpath=(~/.oh-my-zsh/zsh-completions $fpath)

# additional path
path=($HOME/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin $path)

# Mac brew
if which brew > /dev/null; then
        export BYOBU_PREFIX=$(brew --prefix)
        path=($(brew --prefix coreutils)/libexec/gnubin $path)
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