zmodload zsh/zprof

export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="firefox"
export QT_QPA_PLATFORMTHEME=qt5ct
export PAGER=nvimpager
# export PAGER=less
export MANPAGER="nvim +Man!"

# export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;43:ow=0;42:'
export GREP_COLOR='1;33'

#npm
export PATH="$HOME/.local/bin:$PATH"
export npm_config_prefix="$HOME/.local"
#npm end

#cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Usual XDG Paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"


#android variables
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

#ruby variables
# export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
# export PATH="$PATH:$GEM_HOME/bin"

#add tmuxifier and other tmux plugins to path
export PATH="$HOME/.config/tmux/plugins/tmuxifier/bin:$PATH"

#Add scripts to PATH
export PATH="$HOME/.local/scripts:$PATH"

#Add doom emacs path
export PATH="$HOME/.config/emacs/bin:$PATH"
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

#developing wofi-pass
export PATH="$HOME/wofi-pass:$PATH"

#hledger path
export LEDGER_FILE="$HOME/ledger/journal.hledger"
