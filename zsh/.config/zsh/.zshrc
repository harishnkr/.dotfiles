#(cat ~/.cache/wal/sequences &)

bindkey -e

# On slow systems, checking the cached .zcompdump file to see if it must be 
# regenerated adds a noticable delay to zsh startup.  This little hack restricts 
# it to once a day.  It should be pasted into your own completion file.
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
autoload -Uz compinit 
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

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


# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

# stuff starting with $ is not visible
ZSH_HIGHLIGHT_STYLES[comment]='fg=red'

# source $ZDOTDIR/lscolors.sh
DIR_COLORS_FILE="$HOME/TermRainbow/dir_colors"
test -r $DIR_COLORS_FILE && eval $(dircolors $DIR_COLORS_FILE)

# source prompt format
source $ZDOTDIR/plugins/prompt.zsh

source "$HOME/.config/lf/lfcd.sh"

eval "$(tmuxifier init -)"

#autoload -U history-search-end
#zle -N history-beginning-search-backward-end 
#zle -N history-beginning-search-forward-end 
#
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[3~" delete-char

#source aliases
source $ZDOTDIR/.aliases


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
# Source your static plugins file. Keep last maybe
source $zsh_plugins

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


