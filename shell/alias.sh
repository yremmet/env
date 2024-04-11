#!/bin/zsh
if  [ -x "$(command -v exa)" ]; then
  alias ls="exa -abghl --git --color=automatic"
fi

if  [ -x "$(command -v nvim)" ]; then
  alias vim="nvim"
fi

if  [ -x "$(command -v music)" ]; then
  alias mu="music vol up"
  alias md="music vol down"
  alias mn="music next"
  alias mp="music previous"
  alias m="music"
  alias ml="music vol"
  mt()
  {
    if [[ "Music is paused" == "$(music status)" ]]; then
       music play 
    else
       music pause
    fi
    
  }
fi

alias weather='curl wttr.in/Wiesbaden'
alias dev='cd $DEV_PATH'

if  [ -x "$(command -v brew)" ]; then
  alias uuc="brew update && brew upgrade && brew cleanup"
fi

# KUBECTL
if  [ -x "$(command -v kubectl)" ]; then
  alias k="kubectl"
  alias kg="kubectl get all -n"
  alias ka="kubectl get all -A"
  alias kl="kubectl logs"
  alias kd="kubectl describe"
  alias kx="kubectl delete"
  alias ke="kubectl exec"
  alias kc="kubectl apply"
  alias kx="kubectl config use-context"
  alias kxs="kubectl config get-contexts"
fi
