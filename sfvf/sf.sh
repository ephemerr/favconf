#!/bin/bash

# without arg show last log
if [ "$1" = "" ]; then 
    if test -e ".sfvf"; then cat ".sfvf"; fi
    exit 0
fi

# remove last log
if test -e ".sfvf"; then rm ".sfvf"; fi

# serch
for line in $(find -L . -name "*.c" -o -name "*.h" -o -name "*.cpp"); do  
    lawk "/usr/local/bin/sf.lua" "$line" $1
done
