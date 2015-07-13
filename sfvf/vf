#!/bin/bash
declare ARG=$1

# without arg show first entry
if [ "$ARG" = "" ]; then ARG=1; fi

# start vim on line
`sed -nr "
    $ARG {   
    s:\x1B\[[0-9;]*[mK]::g # remove color codes 
    s/([0-9]+).[\t ]+([0-9]+)[\t \27]([^\t ]+)[\t ]+([^\n]+)/vims \+\2 \3/p # args for vim
    }
    " ./.sfvf`
