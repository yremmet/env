function code () {
    open $1 -a Visual\ Studio\ Code
}

function delete-tag() {
	git push --delete origin $1
	git tag --delete $1
}

function extract()      
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function get_website() 
{ 
	wget --limit-rate=200k --no-clobber --convert-links --random-wait -r -p -E -e robots=off -U mozilla $1 ; 
}

function rand(){
    cat /dev/urandom | env LC_CTYPE=C tr -dc ${1:-'a-zA-Z0-9'} | fold -w ${2:-32} | head -n 1
}

function random_small(){
    rand 'a-z0-9' $1
}

function rnd(){
    rand "a-zA-Z0-9!@#$%^&*()_+?><~\`;'" $1
}

function id(){
  for ((i=1;i<=${1:-"1"};i++)); 
  do 
    echo "$(random_small 8)-$(random_small 4)-$(random_small 4)-$(random_small 12)"
  done
}

function pass(){
    ou=false
    op=false
    on=false
    serach_params=()
    while [[ $# -gt 0 ]] ; do
        var=$1
        case $var in
            "-p")
                op=true
                shift
            ;;
            "-u")
                ou=true;
                shift
            ;;
            "-n")
                on=true;
                shift
            ;;
            *)
                serach_params+=($var)
                shift
            ;;
        esac
    done
#    [[ !ou && !op && !on ]] && ou=true; op=true; on=true

    while IFS= read -r line ; do
      user=$(echo $line | awk '{print $2}')
      name=$(echo $line | awk '{print $1}') 
      id=$(echo $line | awk '{print $6}') 
      password=$(passbolt get $id |  gpg -d 2> /dev/null)
      if [[ $linebreak ]]; then
        printf "\n"
      fi
      if [[ $on ]]; then
        printf "$name\t"
      fi
      if [[ $ou ]]; then
        printf "$user\t"
      fi
      if [[ $op ]]; then
        printf "$password\t"
      fi
      linebreak=true
    done <<< $(passbolt find | grep -i "$serach_params")    
}

function wait(){
    if [[ $1 == "-n" ]]; then
        sleep="$2"
        shift;
        shift;
    else
        sleep="2"
    fi

    let "length = $# - 1"
    array=${*}

    while true; do
        eval ${array}
        sleep $sleep
    done
}

function update(){
    brew update
    brew upgrade
    for app in $(brew cask list); do 
        brew cask reinstall $app
    done
    brew cleanup
}