# this theme uses prompt sequences, check the section
# 'EXPANSION OF PROMPT SEQUENCES' in the zshmisc man page

# Theme colors
local date_color=$fg[white]

local normal_user_color=$fg[yellow]
local root_user_color=$fg_bold[red]

local at_symbol_color=$fg[green]

local remote_system_color=$fg_bold[red]
local local_system_color=$fg_bold[yellow]

local dir_color=$fg[green]
local real_dir_color=$fg_bold[black]

local return_code_color=$fg_bold[grey]

local running_jobs_color=$fg_bold[blue]
local suspended_jobs_color=$fg_bold[red]

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
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[yellow]%}☰"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Change color based if is a normal user or a root user
local user='%(!.%{$root_user_color%}.%{$normal_user_color%})%n%{$reset_color%}'
local at='%{$at_symbol_color%}@%{$reset_color%}'

# Change host color based if it is on a ssh connection
# The temporary file is used as when changing users remotely
# (eg. sudo -s), the environment vars are not passed forward
# by default, so the SSH_CONNECTION may be lost
local on_ssh_file=/tmp/.zsh-ssh-used.5521624
if [[ ${#SSH_CONNECTION} > 0 || -f $on_ssh_file ]]; then
    touch $on_ssh_file
    local host='%{$remote_system_color%}%M%{$reset_color%}'
else
    local host='%{$local_system_color%}%M%{$reset_color%}'
fi

local date='%{$date_color%}[%*]%{$reset_color%}'
local git='$(git_prompt_info) $(git_prompt_status) %{$reset_color%}'
local dir='%{$dir_color%}%~%{$reset_color%}'
local real_dir='$(real=$(readlink -f .) && [[ "$PWD" != "$real" ]] && echo -n " %{$real_dir_color%}${real}%{$reset_color%}")'

local return_code='%{$return_code_color%}(%?)%{$reset_color%}'

local running_jobs='$(jobs | grep running | wc -l | awk '\''$1 > 0 {print "'%{$running_jobs_color%}'" $1 " running'%{$reset_color%}'" }'\'')'
local suspended_jobs='$(jobs | grep suspended | wc -l | awk '\''$1 > 0 {print "'%{$suspended_jobs_color%}'" $1 " suspended'%{$reset_color%}'" }'\'')'

PROMPT="${return_code} ${date} ${user}${at}${host} ${dir}${real_dir}${git}%{$reset_color%}
%# "
RPROMPT="${running_jobs} ${suspended_jobs}"
