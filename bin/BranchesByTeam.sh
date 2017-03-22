#!/bin/sh

declare -a teams=("einstein" "(fj|feedjunkies)" "ipa" "mint" "platform" "tesla" "architect")

for team in "${teams[@]}"
do
    count="$(git branch -r | grep -i -E origin/${team} | wc -l)"
    echo "${team}: ${count}"
done
#git rev-list --left-right --count master...origin/tesla
