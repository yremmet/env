
if  [ -x "$(command -v exa)" ]; then
  alias ls="exa -abghl --git --color=automatic"
fi

alias weather='curl wttr.in/Wiesbaden'
alias dev="cd $DEV_PATH"

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
fi
