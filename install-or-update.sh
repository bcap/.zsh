#!/bin/bash

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
git branch --set-upstream master origin/master
if ! git branch | grep -e '^* master$' > /dev/null; then git checkout master; fi
git merge origin/master
git merge forkro/master

# create the symbolic link
if [ ! -e "$HOME/.zshrc" ]; then ln -s -v $(dirname $0)/.zshrc "$HOME/.zshrc"; fi
