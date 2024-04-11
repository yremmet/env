#!/bin/zsh

if [[ "$0" == "-bash" ]] ; then
  if [ -z "$include_path" ]; then
    include_path=$(dirname $(find / -name index.sh 2>/dev/null  | head -n1))
    sed -i "1i\export include_path=$include_path" ~/.bashrc
  fi
else
  include_path=$(dirname "$0")
fi

. ${include_path}/alias.sh
. ${include_path}/function.sh

