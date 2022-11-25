#!/bin/bash

echo "run-sh: Inside auto-check-changed-files.sh"

# print content of json holding all files to be checked
a=$(cat /home/runner/files.json)
echo "Content of files.json: $a" 

# get number of files to check
num_files=$(jq '. | length' /home/runner/files.json)
echo "number of files to check = $num_files"

# loop over each file to be checked
for file in $(jq  '.[]' /home/runner/files.json | cut -d '"' -f 2); do
    echo "checking file: $file"

done