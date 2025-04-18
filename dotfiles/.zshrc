# If you come from bash you might have to change your $PATH.

export PATH=$HOME/env/bin:/usr/local/bin:/opt/homebrew/bin/:$PATH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
source $ZSH/oh-my-zsh.sh
if  [ -x "$(command -v nvim)" ]; then
  export EDITOR='nvim'
else 
  export EDITOR='vim'
fi
export LANG=de_DE.UTF-8
export DEV_PATH="~/DEV"

if [ $(uname) = "Darwin" ]; then
  plugins=(git docker docker-compose podman thefuck macos iterm2)
else 
  plugins=(git)
fi

. $(brew --prefix asdf)/libexec/asdf.sh

if [ -d "~/env/secrets/" ]; then
  for f in $(ls ~/env/secrets/); do
  . $f
  done
fi

[ -f ~/env/shell/index.sh  ] && source ~/env/shell/index.sh 
[ -f ~/.asdf/plugins/java/set-java-home.zzh ] && source ~/.asdf/plugins/java/set-java-home.zsh

eval "$(direnv hook zsh)"

GO_PATH="~/dev/golang/"
export PATH="$HOME/.local/bin:$PATH"
