# If you come from bash you might have to change your $PATH.

export PATH=$HOME/env/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"

if [ $(uname) = "Darwin" ]; then
  plugins=(git cf zsh-syntax-highlighting osx)
else 
  plugins=(git cf zsh-syntax-highlighting)
fi

source $ZSH/oh-my-zsh.sh
export EDITOR='nvim'
export LANG=de_DE.UTF-8
export PATH=$PATH:~/.config/bin:/Users/yremmet/DEV/servicebroker/cf-helper/scripts
export SB_DEV_PATH=/Users/yremmet/DEV/servicebroker

source ~/env/shell/index.sh 
if [[ -f ~/env/secrets ]]; then
  source ~/env/secrets
fi

