#!/bin/bash

max=$(wc -l < saves/${username}.list.fail)
rand_line=$(echo "${RANDOM} % ${max}" | bc)
nld_line=$(awk "NR==${rand_line}" saves/${username}.list.fail)
nld_word=$(echo ${nld_line} | awk '{ print $1 }')
