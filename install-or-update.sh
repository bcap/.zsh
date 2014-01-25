#!/bin/bash

# Fix for when running this script by puppet.
# the HOME can be passed as an argument so the messed $HOME
# from puppet 2.X.X wont create problems
if [[ $# > 0 ]]; then HOME=$1; fi

cd $(dirname $0)

# check for a git repo
if [ ! -d .git ]; then git init; fi

# adjust remotes
git remote | grep -q -e '^fork$'   || git remote add -t master fork   git@github.com:bcap/oh-my-zsh.git
git remote | grep -q -e '^forkro$' || git remote add -t master forkro git://github.com/bcap/oh-my-zsh.git
git remote | grep -q -e '^origin$' || git remote add -t master origin git://github.com/robbyrussell/oh-my-zsh.git

# checkout and adjust master
git branch | grep -q -e '^* master$' || git checkout master
git branch -vv | grep -q '[fork/master]' || git branch --set-upstream-to fork/master

# merge remotes into master
export GIT_MERGE_AUTOEDIT=no
git pull fork master
git pull origin master
git pull forkro master

# create the symbolic link
test ! -e "$HOME/.zshrc" && ln -s -v "$(pwd)/.zshrc" "$HOME/.zshrc"
