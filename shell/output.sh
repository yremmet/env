OUTPUT_FORMAT="+%H:%M:%S"

NC='\033[0m' # No Color

BOLD='\e[1m'
DIM='\e[2m'
UNDERLINED='\e[4m'


BLACK='\033[0;30m'
DARK_GRAY='\033[1;30m'
RED='\033[0;31m'
LIGHT_RED='\033[1;31m'
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
LIGHT_BLUE='\033[1;34m'
PURPLE='\033[0;35m'
LIGHT_PURPLE='\033[1;35m'
CYAN='\033[0;36m'
LIGHT_CYAN='\033[1;36m'
LIGHT_GRAY='\033[0;37m'
WHITE='\033[1;37m'
BACKGROUND_DARKGREY="\e[48;5;237m"


# exits with error code 1 and message $1
fail() {
    echo::label RED ERROR "$@"
    exit 1
}

# exits with a fail message $2 and errorcode 1 if $1 is empty or 'null'
fail_on_noval() {
  if [ "null" == "$1" ] || [ -z "$1" ]; then
    fail "$2"
  fi
}

# exits with error code 1 if the file in $1 is not found
fail_on_file_not_found() {
  if [ ! -f "$1" ]; then
    fail "file $1 not found - aborting."
  fi
}

info() {
    echo::label $BLUE INFO "$@"
}

ok() {
    echo::label $GREEN OK "$@"
}

warn() {
    echo::label $ORANGE WARN "$@"
}


header() {
    pad=$(printf '%0.1s' "="{1..80})
    x=$(((80 - ${#1} -1)/2))
    printf "${BOLD}${RED}${BACKGROUND_DARKGREY}%*.*s${NC}" 0 $x $pad
    printf "${BOLD}${BACKGROUND_DARKGREY} %s " "$1"
    printf "${BOLD}${RED}${BACKGROUND_DARKGREY}%*.*s${NC}\n" 0 $x $pad
}

header2() {
    pad=$(printf '%0.1s' "-"{1..80})
    x=$(((80 - ${#1} -1)/2))
    printf "${BOLD}${GREEN}%*.*s${NC}" 0 $x $pad
    printf "${GREEN} %s " "$1"
    printf "${BOLD}${GREEN}%*.*s${NC}\n" 0 $x $pad
}

echo::label(){
    color=$1
    label=$2
    shift
    shift
    printf "${color}[${label}] ${LIGHT_GRAY}$(date ${OUTPUT_FORMAT})${color} $@ $NC"
    echo ""
}

echo::color(){
    color=$1
    shift
    printf "${color} $@ $NC"
    echo ""
}

echo::green()
{
    echo::color $GREEN "$@"
}

echo::red()
{
    echo::color $RED "$@"
}

echo::blue()
{
  echo::color $BLUE "$@"
}

function printTable(){
    printf "%15s %15s %15s %50s\n" "${1:-" "}" "${2:-" "}" "${3:-" "}" "${4:-" "}"
}

function printTableAlt(){
    printf "${BACKGROUND_DARKGREY}%15s %15s %15s %50s ${NC}\n" "${1:-" "}" "${2:-" "}" "${3:-" "}" "${4:-" "}"
}

function printTableHead(){
    printf "${RED}${BACKGROUND_DARKGREY}%15s %15s %15s %50s \n${NC}" "${1:-" "}" "${2:-" "}" "${3:-" "}" "${4:-" "}"
}