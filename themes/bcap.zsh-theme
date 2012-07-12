ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

local user='%(!.%{$fg_bold[red]%}.%{$fg[yellow]%})%n%{$reset_color%}'
local at='%{$fg[green]%}@%{$reset_color%}'
local host='%{$fg_bold[yellow]%}%M%{$reset_color%}'

local date='%{$fg[white]%}[%*]%{$reset_color%}'
local git='$(git_prompt_info)% %{$fg_bold[grey]%}%{$reset_color%}'
local dir='%{$fg[green]%}%~%{$reset_color%}'

local return_code='%{$fg_bold[grey]%}(%?)%{$reset_color%}'

local running_jobs='%{$fg_bold[blue]%}$(jobs | grep running | wc -l | awk '"'"'$1 > 0 {print $1 " running" }'"'"')%{$reset_color%}'
local suspended_jobs='%{$fg_bold[red]%}$(jobs | grep suspended | wc -l | awk '"'"'$1 > 0 {print $1 " suspended" }'"'"')%{$reset_color%}'

PROMPT="${return_code} ${date} ${user}${at}${host} ${dir}${git} %{$reset_color%}
%# "
RPROMPT="${running_jobs} ${suspended_jobs}"
