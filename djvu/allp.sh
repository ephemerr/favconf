
function files { 
    find  -iname "*.djvu"  -printf "%p\n"
}

function shots(f) {
    for i = (1 .. 8)
    do
        page.sh $f $i
    done
}

function batchshots {
    for file in `files`
    do
        shots(file)
    done
}

$1
