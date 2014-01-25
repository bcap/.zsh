#!/bin/bash

# Fix for when running this script by puppet.
# the HOME can be passed as an argument so the messed $HOME
# from puppet 2.X.X wont create problems
if [[ $# > 0 ]]; then HOME=$1; fi

cd $(dirname $0)

# check for a git repo
if [ ! -d .git ]; then git init; fi

# adjust remotes
git remote | xargs -I '$' git remote rm '$'
git remote add -t master fork   git@github.com:bcap/oh-my-zsh.git
git remote add -t master forkro git://github.com/bcap/oh-my-zsh.git
git remote add -t master origin git://github.com/robbyrussell/oh-my-zsh.git
git fetch forkro
git fetch origin

# checkout and update master
if ! git branch | grep -q -e '^* master$'; then git checkout master; fi
git branch --set-upstream-to fork/master
git merge origin/master
git merge forkro/master

# create the symbolic link
if [ ! -e "$HOME/.zshrc" ]; then ln -s -v "$(pwd)/.zshrc" "$HOME/.zshrc"; fi
