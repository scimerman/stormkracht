#!/bin/bash

dir=$(dirname $0)
cd ${dir}

topdown=true # by default we do topdown
loop=false
noprompt=false
random=false
retry=false
user=false
tmp_fail_count=0
tmp_success_count=0
tmp_total_count=0
username="default"

if [[ "${#}" -lt 1 ]]; then
   echo "${0} [-noprompt] [-loop] [-random|-topdown-retry|any word] -user=X"
   exit 1
fi

while [[ $# -gt 0 ]]; do
   case $1 in
     "-noprompt")
        noprompt=true
        ;;
     "-loop")
        loop=true
        echo "loop = true"
        ;;
     "-random")
        random=true
        ;;
     "-topdown")
        topdown=true
        ;;
     "-retry")
        retry=true
        ;;
     "-user="*)
        user=true
	username=${1:6}
        ;;
      *)
        nld_word="$1"
	;;
   esac
   shift
done

function main(){
   test -d saves || mkdir saves
   if ${random};  then source random.sh; fi
   if ${topdown}; then source topdown.sh; fi
   if ${retry};   then source retry.sh; fi
   
   echo "[ words = $max ] [ this line = $thisline ] [ nld_word = $nld_word ]"
      echo ""
      echo -n "translate: '$nld_word' > "
      read mytranslation
      translation="$(./translate_from_dictionary.sh ${nld_word})"
      translation="${translation}
      $(./translate_from_google.sh nl en ${nld_word})"
      correct=false
      while read line ; do
         if [[ ${line,,} == ${mytranslation,,} ]]; then
            correct=true
         fi
      done <<< "${translation}"
      source check_and_save.sh
      echo "the full translation is: "${translation}
      echo "In past you had answered correct $(awk -v nld_word=${nld_word} '$1 == /$nld_word/ { if (NF < 2) { print "0" } else { print $2 } }' saves/${username}.list.success) times and wrong $(grep $nld_word saves/${username}.list.fail | wc -l) times: $(awk -v nld_word=${nld_word} '$1 == nld_word { $1=""; print $0 }' saves/${username}.list.fail | tr -d '\n')"
   echo "Success rate | current $(echo "scale=2;(${tmp_success_count}/${tmp_total_count})*100" | bc -l) | total $(echo "scale=2;($(wc -l < saves/${username}.list.success)/($(wc -l < saves/${username}.list.fail)+$(wc -l < saves/${username}.list.success)))*100" | bc -l)"
}

# Check files
for _file in last.line list.fail list.success; do
   test -w saves/${username}.${_file} || {
      echo "Creating file saves/${username}.${_file} ..."
      touch saves/${username}.${_file}
   }
done
echo "Running for user > $username <"

# Main loop that starts loop
if ${loop} ; then
   while : ; do main; done
else
   main
fi
