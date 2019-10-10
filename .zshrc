# If you come from bash you might have to change your $PATH.

export PATH=$HOME/env/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

if [ $(uname) = "Darwin" ]; then
  plugins=(git docker docker-compose kubectl thefuck osx iterm2)
else 
  plugins=(git)
fi

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'
export LANG=de_DE.UTF-8
export DEV_PATH="~/DEV"
export SB_DEV_PATH="${DEV_PATH}/osb"

source ~/env/shell/index.sh 
if [[ -f ~/env/secrets ]]; then
  source ~/env/secrets
fi

