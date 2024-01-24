pathdir=$(dirname $0)

if [ ! -f output.sh ]; then
    curl --silent https://gist.github.com/yremmet/1a77ac70b1a24cb901e28233219c5663/raw -Lo output.sh
fi
. $pathdir/output.sh


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
        echo "Evaluating ${array} every ${sleep} seconds."
        eval ${array} 
        sleep $sleep
        clear;
    done
    
}


function kib(){
    pod_name="${USER}-tmp-iacbox"
    pod_image="enat/iac_box"
    echo "[INFO] Running pod '$pod_name' with image '$pod_image' and attaching onto it ..."
    kubectl run $pod_name -it --image $pod_image --restart=Never  -- sh
    
    echo "[INFO] Unattached from pod and deleting it ..."
    kubectl delete pod $pod_name
}

function kbb(){
    pod_name="${USER}-tmp-busybox"
    pod_image="busybox"
    echo "[INFO] Running pod '$pod_name' with image '$pod_image' and attaching onto it ..."
    kubectl run $pod_name -it --image $pod_image --restart=Never  -- sh
    
    echo "[INFO] Unattached from pod and deleting it ..."
    kubectl delete pod $pod_name
}

function backup() {
    echo "Backup Little Snitch"
    sudo littlesnitch export-model > ~/env/mac/littlesnitch/ls.json
    pushd ~/env/
    git add ~/env/mac/littlesnitch/
    git commit -m "cfg backup"
    popd
}

function restore(){
    echo "Restore Little Snitch Config"
    sudo littlesnitch restore-model ~/env/mac/littlesnitch/ls.json
}