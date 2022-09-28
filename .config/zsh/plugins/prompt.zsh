autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git*' formats "%r/%S %b (%a) %m%u%c "
setopt PROMPT_SUBST
#PROMPT='%n in ${PWD/#$HOME/~} >'
#RPROMPT=\$vcs_info_msg_0_
#autoload -U colors && colors
export PS1="%F{blue}%K{000}%m%F{cyan}%K{green}:%F{039}%K{000}%~%F{015}%K{000}\$ "
