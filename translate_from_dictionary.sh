#!/bin/bash

if [ $# -ne 1 ]; then echo error, just one parameter needed: word to be translated; exit 1; fi 

cat sources/nld-eng.tei | tr '\n' ' ' | sed 's|\/entry>|\/entry>\n|g' | grep -iE "orth>${1}<" | sed 's|<quote>|\n<quote>|g' | grep quote | sed 's|[<>]| |g' | awk '{print $2}'
