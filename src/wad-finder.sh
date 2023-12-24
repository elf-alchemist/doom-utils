#!/usr/bin/env bash

# Bash's unofficial strict mode
set -euo pipefail

dir_data="${XDG_DATA_HOME:="$HOME/.local/share"}"

dir_main="$dir_data/wad-finder"

dir_iwad="$dir_data/wad-finder/doom-iwad"
dir_ewad="$dir_data/wad-finder/doom-ewad"

iwad_doom_2="$dir_data/wad-finder/doom-iwad/doom2.wad"
iwad_doom_1="$dir_data/wad-finder/doom-iwad/doom1.wad"
iwad_doom_u="$dir_data/wad-finder/doom-iwad/doomu.wad"

ewad_nerve="$dir_data/wad-finder/doom-ewad/nerve.wad"
ewad_sigil_1="$dir_data/wad-finder/doom-ewad/sigil1.wad"
ewad_sigil_2="$dir_data/wad-finder/doom-ewad/sigil2.wad"

check_steam_directory() {
    echo "[ Info ]: Checking Steam directory."

    if ! [ -d "$dir_data/Steam" ]; then
	echo "[ Error ]: Steam directory does exit, have you installed it on the $XDG_DATA_HOME?"
	exit 1
    fi

    echo "[ Success ]: Steam directory found."
    return 0
}

check_doom_1_directory() {
    echo "[ Info ]: Checking Doom installation."

    if ! [ -d "$dir_data/Steam/steamapps/common/Ultimate Doom" ]; then
	echo "[ Error ]: Could not find Ultimate Doom intallation."
	echo "[ Error ]: Check your Ultimate Doom installation on the Steam Client."
	echo "[ Error ]: Make sure to install in your \$XDG_DATA_HOME"
    fi

    echo "[ Success ]: Ultimate Doom steam installation found."
    return 0
}

check_doom_2_directory() {
    echo "[ Info ]: Checking Doom 2 installation."

    if ! [ -d "$dir_data/Steam/steamapps/common/Doom 2" ]; then
	echo "[ Error ]: Could not find Doom 2 intallation."
	echo "[ Error ]: Check your Doom 2 installation on the Steam Client."
	echo "[ Error ]: Make sure to install in your \$XDG_DATA_HOME"
    fi

    echo "[ Success ]: Doom 2 steam installation found."
    return 0
}

main() {
    check_steam_directory
    check_doom_1_directory
    check_doom_2_directory
    return 0
}

main "$@"

