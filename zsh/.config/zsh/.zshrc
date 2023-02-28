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




# Set the name of the static .zsh plugins file antidote will generate.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins.zsh

# Ensure you have a .zsh_plugins.txt file where you can add plugins.
[[ -f ${zsh_plugins:r}.txt ]] || touch ${zsh_plugins:r}.txt

# Lazy-load antidote.
fpath+=(${ZDOTDIR:-~}/.antidote)
autoload -Uz $fpath[-1]/antidote

# Generate static file in a subshell when .zsh_plugins.txt is updated.
if [[ ! $zsh_plugins -nt ${zsh_plugins:r}.txt ]]; then
  (antidote bundle <${zsh_plugins:r}.txt >|$zsh_plugins)
fi

# Source your static plugins file.
source $zsh_plugins




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
