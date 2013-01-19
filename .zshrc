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

if which git > /dev/null; then
	plugins=(git)
fi

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

HISTSIZE=10000
SAVEHIST=10000

export EDITOR=vim

alias ll='ls -lhp --color=auto'
alias la='ll -A'

# Mac brew
if which brew > /dev/null; then
	export BYOBU_PREFIX=$(brew --prefix)
	path=($(brew --prefix coreutils)/libexec/gnubin $path)
fi

# additional fpath
fpath=(~/.oh-my-zsh/zsh-completions $fpath)

# additional path
path=(~/bin /usr/local/bin /usr/local/sbin $path)

# aws stuff
export EC2_PRIVATE_KEY=$(echo $HOME/Dropbox/nix/aws/pk-*.pem)
export EC2_CERT=$(echo $HOME/Dropbox/nix/aws/cert-*.pem)
export AWS_CREDENTIAL_FILE=$HOME/Dropbox/nix/aws/aws-credentials-fullaccess
