#!/bin/bash
declare FILE=$1
declare PAGE=$2
declare OUT="${FILE//.djvu/} $2"
shopt -s -o xtrace

ddjvu -format=pnm -page=$PAGE "$FILE" $PAGE.pnm
convert $PAGE.pnm "$OUT.jpg"
rm $PAGE.pnm
