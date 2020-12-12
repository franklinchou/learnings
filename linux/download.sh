#!/bin/bash

# Download all the files with JPG extension in a sequence by providin the following positional parameters:
# 1 source
# 2 ending index
# 3 output destination

# set up (create output destination if it doesn't exist)
if [ -d "$3" ]; then
    echo 'choose new directory'
    exit 1
else
    mkdir $3
fi

for i in $(seq -w 1 $2); do
    source=$1
    dest=$(echo $source | awk -v i=$i '{ gsub(/0[0-9]+\.JPG/, i ".JPG"); print }')
    $(curl -X GET "$dest" -o "$3/$i.jpg")
done

