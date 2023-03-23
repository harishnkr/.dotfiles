#(cat ~/.cache/wal/sequences &)

bindkey -e
autoload -Uz compinit && compinit -i
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

#For delete key to function in st
#function zle-line-init () { echoti smkx }
# function zle-line-finish () { echoti rmkx }
# zle -N zle-line-init
# zle -N zle-line-finish

ANTIDOTE_DIR=${ZDOTDIR}/.antidote
if [ ! -d ${ANTIDOTE_DIR} ]
then
	(git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR}/.antidote)
fi


zsh_plugins=${ANTIDOTE_DIR}/.zsh_plugins.zsh


# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${ZDOTDIR}/.zsh_plugins.txt ]]; then
  (antidote bundle <${ZDOTDIR}/.zsh_plugins.txt >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins


# source prompt format
source $ZDOTDIR/plugins/prompt.zsh

source "$HOME/.config/lf/lfcd.sh"

#autoload -U history-search-end
#zle -N history-beginning-search-backward-end 
#zle -N history-beginning-search-forward-end 
#
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[3~" delete-char

#source aliases
source $ZDOTDIR/.aliases







