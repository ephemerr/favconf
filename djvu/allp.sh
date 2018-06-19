#!/bin/bash
shopt -s -o xtrace

IFS=$'\n'

function files { 
    find  . -maxdepth 1 -iname "*.djvu"   -printf "%p\n"
}

function shots {
    for i in {1..12}
    do
        page.sh "$1" $i
    done
}

function folder {
    for file in `files`
    do
        shots "$file"
    done
}

$1 "$2"
