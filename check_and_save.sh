#!/bin/bash
tmp_total_count=$((tmp_total_count+1))
if $correct; then
   echo -e "    \033[32mcorrect!\033[0m"
   OLD_COUNT=$(awk -v nld_word=${nld_word} '$1 == nld_word { $1=""; print $0 }' saves/${username}.list.success | tr -d ' ')
   if [[ "x${OLD_COUNT}" != "x" ]]; then COUNT=$((OLD_COUNT+1)); else COUNT=1; fi
   grep -q ${nld_word} saves/${username}.list.success && sed -i "s/^'\("${nld_word}"\)' .*/$'\1' "${COUNT}"/" saves/${username}.list.success || echo "${nld_word} ${COUNT}" >> saves/${username}.list.success
   tmp_success_count=$((tmp_success_count+1))
else
   echo -e "    \033[31merror!\033[0m"
   PREVIOUS=$(awk -v nld_word=${nld_word} '$1 == /$nld_word/ { $1=""; print $0 }' saves/${username}.list.fail )
   echo "${nld_word} '${mytranslation}'" >> saves/${username}.list.fail
   tmp_fail_count=$((tmp_fail_count+1))
fi

if ! ${random} ; then echo "${thisline}" > saves/${username}.last.line ; fi
