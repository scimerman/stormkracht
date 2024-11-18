#!/bin/bash

max=$(cat sources/nl_frequency.txt | wc -l )
rand_line=$(echo "${RANDOM} % ${max}" | bc)
nld_line=$(awk "NR==${rand_line}" sources/nl_frequency.txt)
nld_word=$(echo ${nld_line} | awk '{ print $1 }')
