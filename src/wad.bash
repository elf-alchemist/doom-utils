#!/usr/bin/env bash

# Bash strict mode
set -o errtrace
set -o errexit
set -o nounset
set -o pipefail

IFS=$'\n\t'
LC_ALL=C
LANG=C
ARGS=$*

declare -A dir
declare -A iwad
declare -A ewad
declare -A sha1

dir_data="${XDG_DATA_HOME:="${HOME}/.local/share"}"
dir_main="${dir_data}/doom"

dir["main"]="${dir_main}"
dir["iwad"]="${dir_main}/iwad"
dir["ewad"]="${dir_main}/ewad"

iwad["doom_2"]="${dir_main}/iwad/doom2.wad"
iwad["doom_1"]="${dir_main}/iwad/doom1.wad"

ewad["nerve"]="${dir_main}/ewad/nerve.wad"
ewad["sigil_1"]="${dir_main}/ewad/sigil1.wad"
ewad["sigil_2"]="${dir_main}/ewad/sigil2.wad"

sha1["iwad_doom_2"]="7ec7652fcfce8ddc6e801839291f0e28ef1d5ae7"
sha1["iwad_doom_1"]="9b07b02ab3c275a6a7570c3f73cc20d63a0e3833"

sha1["ewad_nerve"]="3451288383fb16e196f273d9f85d58c1fda97bf4"
sha1["ewad_sigil_1"]="e2efdf379e1383c4e15c03de89063361897cd459"
sha1["ewad_sigil_2"]="ad2c6e8367afbeef74e9e09b6b1e4da88c0576b4"

function supports_color()  {
    if command -v tput > /dev/null; then
        if [[ "$(tput colors)" -ge 8 ]]; then
            return 0
        fi
    elif [[ -n "${TERM}" ]]; then
        case "${TERM}" in
            xterm | xterm-256color | rxvt | screen*)
                return 0
                ;;
        esac
    fi
    return 1
}

if supports_color; then
    # Color modifiers;
    FG_BLACK="\e[30m"
    FG_RED="\e[31m"
    FG_GREEN="\e[32m"
    FG_YELLOW="\e[33m"
    FG_BLUE="\e[34m"
    FG_MAGENTA="\e[35m"
    FG_CYAN="\e[36m"
    FG_WHITE="\e[37m"
    # Non-color modifiers;
    RESET="\e[0m"
    BOLD="\e[1m"
    UNDERLINE="\e[4m"
else
    # Color modifiers;
    FG_BLACK=""
    FG_RED=""
    FG_GREEN=""
    FG_YELLOW=""
    FG_BLUE=""
    FG_MAGENTA=""
    FG_CYAN=""
    FG_WHITE=""
    # Non-color modifiers;
    RESET=""
    BOLD=""
    UNDERLINE=""
fi

function success() {
    echo -e "${FG_GREEN}Success${RESET} $1" >&1
}

function info() {
    echo -e "${FG_BLUE}Info${RESET} $1" >&1
}

function warn() {
    echo -e "${FG_YELLOW}Warn${RESET} $1" >&2
}

function error() {
    echo -e "${FG_RED}Error${RESET} $1" >&2
}

# Here be subcommands
function help() {
    echo "Usage: wad SUBCOMMAND" >&1
    exit 0
}

check() {
    if ! [[ -d "${dir_data}/Steam" ]]; then
        error "Steam directory does exit, have you installed it on the \$XDG_DATA_HOME?"
        exit 1
    else
        success "Steam directory found."
    fi

    if ! [[ -d "${dir_data}/Steam/steamapps/common/Ultimate Doom" ]]; then
        error "Could not find Ultimate Doom intallation."
        error "Check your Ultimate Doom installation on the Steam Client."
        error "Make sure to install in your \$XDG_DATA_HOME"
    else
        success "Ultimate Doom steam installation found."
    fi

    info "Checking Doom 2 installation."

    if ! [[ -d "${dir_data}/Steam/steamapps/common/Doom 2" ]]; then
        error "Could not find Doom 2 intallation."
        error "Check your Doom 2 installation on the Steam Client."
        error "Make sure to install in your \$XDG_DATA_HOME"
    else
        success "Doom 2 steam installation found."
    fi

    return 0
}

function list() {
    if ! [[ -d "${dir["main"]}" ]]; then
        mkdir -p "${dir["main"]}"
    fi
    return 0
}

function unknown() {
    echo "Unknown subcommand: ${ARGS[1]} try again" >&2
    exit 1
}

function main() {
    if [[ $# -eq 0 ]]; then
        help;
    fi

    case "${ARGS[1]}" in
         check)
             check
             ;;
         list)
             list
             ;;
         version)
             version
             ;;
         *)
             unknown
             ;;
    esac
    return 0
}

main "$@"

