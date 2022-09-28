#(cat ~/.cache/wal/sequences &)

bindkey -e
autoload -U compinit && compinit -i
autoload -U colors && colors


HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt extended_history
setopt hist_verify
#setopt always_to_end

zmodload zsh/complist
zstyle ':completion:*' menu select=0 interactive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/prompt.zsh

source "$HOME/.config/lf/lfcd.sh"

#autoload -U history-search-end
#zle -N history-beginning-search-backward-end 
#zle -N history-beginning-search-forward-end 
#
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[3~" delete-char


##Aliases
alias r=ranger
alias n=nvim
alias p=pnpm
alias yain="yay -S"
alias yarem="yay -Rns"
alias s="source $ZDOTDIR/.zshrc"
alias c="calcurse"
alias ls="ls -a --color"
alias conf="l  $HOME/.config/"
alias nz="nvim .config/zsh/.zshrc"


alias config='/usr/bin/git --git-dir=/home/hari/dotfiles/ --work-tree=/home/hari'

