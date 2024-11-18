#!/bin/bash

max=$(cat sources/nl_frequency.txt | wc -l )
test -r saves/${username}.last.line && lastline=$(cat saves/${username}.last.line) || lastline=0
thisline=$((lastline+1))
${noprompt} || {
    read -p "Continue from last line ${lastline} [press enter] or select line: " selected
    if [[ "x${selected}" != "x" ]]; then
        thisline=${selected}
    fi
}
nld_line=$(awk "NR==${thisline}" sources/nl_frequency.txt)
nld_word=$(echo ${nld_line} | awk '{ print $1 }')
