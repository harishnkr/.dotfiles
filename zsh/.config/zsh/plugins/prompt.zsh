


setopt PROMPT_SUBST
source $ZDOTDIR/plugins/gitprompt.zsh
export PROMPT=$'\n'' %F{magenta}<%n@%m>%f %F{yellow}[%1~]%f'$'\n'' %# '
RPROMPT=' %F{cyan}%t%f $(git_prompt_string)'
