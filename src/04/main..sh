#!/bin/bash

source ./funcs.sh

if [ $# -ne 0 ] 
then
    echo "Error: didn't expect any parameters"
exit 1
fi

if [[ ! -f ./colors.conf ]]; then
    echo "Error: Config file not found!"
    exit 1
else 
    chmod +r ./colors.conf
fi

takeColour
showInfo | awk -v fc1="$FONT_NAME" -v bg1="$BACK_NAME" -v fc2="$FONT_TEXT" -v bg2="$BACK_TEXT" -v cl="$CLEAN_COLOUR" 'BEGIN{
    FS="="; OFS=""} {print fc1, bg1, $1, "=", cl , fc2, bg2, $2, cl}'
colourInfo
