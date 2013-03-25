# Available git vars:
#
# ZSH_THEME_GIT_PROMPT_PREFIX
# ZSH_THEME_GIT_PROMPT_SUFFIX
# ZSH_THEME_GIT_PROMPT_DIRTY
# ZSH_THEME_GIT_PROMPT_CLEAN
# ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE
# ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE
# ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE
# ZSH_THEME_GIT_PROMPT_AHEAD
# ZSH_THEME_GIT_PROMPT_SHA_BEFORE
# ZSH_THEME_GIT_PROMPT_SHA_AFTER
# ZSH_THEME_GIT_PROMPT_UNTRACKED
# ZSH_THEME_GIT_PROMPT_ADDED
# ZSH_THEME_GIT_PROMPT_ADDED
# ZSH_THEME_GIT_PROMPT_MODIFIED
# ZSH_THEME_GIT_PROMPT_MODIFIED
# ZSH_THEME_GIT_PROMPT_MODIFIED
# ZSH_THEME_GIT_PROMPT_RENAMED
# ZSH_THEME_GIT_PROMPT_DELETED
# ZSH_THEME_GIT_PROMPT_DELETED
# ZSH_THEME_GIT_PROMPT_DELETED
# ZSH_THEME_GIT_PROMPT_STASHED
# ZSH_THEME_GIT_PROMPT_UNMERGED
# ZSH_THEME_GIT_PROMPT_AHEAD
# ZSH_THEME_GIT_PROMPT_BEHIND
# ZSH_THEME_GIT_PROMPT_DIVERGED

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ✗"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[yellow]%}☰"

# Change color based if is a normal user or a root user
local user='%(!.%{$fg_bold[red]%}.%{$fg[yellow]%})%n%{$reset_color%}'
local at='%{$fg[green]%}@%{$reset_color%}'

# Change host color based if it is on a ssh connection
# The temporary file is used as when changing users remotely 
# (eg. sudo -s), the environment vars are not passed forward 
# by default, so the SSH_CONNECTION may be lost
local on_ssh_file=/tmp/.zsh-ssh-used
if [[ ${#SSH_CONNECTION} > 0 || -f $on_ssh_file ]]; then 
	touch $on_ssh_file
	local host='%{$fg_bold[red]%}%M%{$reset_color%}'
else 
	local host='%{$fg_bold[yellow]%}%M%{$reset_color%}'
fi

local date='%{$fg[white]%}[%*]%{$reset_color%}'
local git='$(git_prompt_info) $(git_prompt_status)% %{$fg_bold[grey]%}%{$reset_color%}'
local dir='%{$fg[green]%}%~%{$reset_color%}'

local return_code='%{$fg_bold[grey]%}(%?)%{$reset_color%}'

local running_jobs='%{$fg_bold[blue]%}$(jobs | grep running | wc -l | awk '"'"'$1 > 0 {print $1 " running" }'"'"')%{$reset_color%}'
local suspended_jobs='%{$fg_bold[red]%}$(jobs | grep suspended | wc -l | awk '"'"'$1 > 0 {print $1 " suspended" }'"'"')%{$reset_color%}'

PROMPT="${return_code} ${date} ${user}${at}${host} ${dir}${git} %{$reset_color%}
%# "
RPROMPT="${running_jobs} ${suspended_jobs}"
