export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
export VISUAL="nvim"
export EDITOR="nvim"
export QT_QPA_PLATFORMTHEME=qt5ct
export TERM=kitty
export TERMINAL=kitty
#Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR="nvim"
 else
   export EDITOR="nvim"
 fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
#
#npm
export PATH="$HOME/.local/bin:$PATH"
export npm_config_prefix="$HOME/.local"
#npm end

#android variables
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

#ruby variables
export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
export PATH="$PATH:$GEM_HOME/bin"

