#!/bin/bash
if [[ "${#}" -le 1 ]]; then
   echo "${0} src_lan tar_lan word words"
fi
base_url="https://translate.googleapis.com/translate_a/single?client=gtx&sl=${1}&tl=${2}&dt=t&q="
shift 2
ua='Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/109.0'
qry=$( echo $@ | sed -e "s/\ /+/g" )
full_url=${base_url}${qry}
response=$(curl -sA "${ua}" "${full_url}")
#echo ">${response}<"
#echo ${response} | sed 's/","/\n/g' | sed -E 's/\[|\]|"//g'
echo ${response} | tr ',' '\n' | grep -o '".*"' | tr -d '"' | grep -v nl
