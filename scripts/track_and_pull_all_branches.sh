#!/bin/bash

# branch - How to fetch all git branches? - Stack Overflow
# https://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branches#_=_
git branch -r | grep -v '\->' | while read branch;
    do  echo "$PWD";
        echo "${branch#*origin/}"; # remove string "*origin/"
        git branch --track ${branch#*origin/} ${branch};
done


git fetch --all

# 【冷知識】斷頭（detached HEAD）是怎麼一回事？ - 為你自己學 Git | 高見龍
# https://gitbook.tw/chapters/faq/detached-head.html
# 
# 前面提到當 HEAD 沒有指到某個分支的時候，它會呈現 detached 狀態。事實上，
# 更正確的說，應該是說「當 HEAD 沒有指到某個『本地』的分支」就會呈現這個狀態。
# 
# git checkout origin/master # 這樣會產生 detached HEAD
#
# 解決辦法：
# 在本地端建立一個 local branch A 並 track 到 remote branch A
# 再 git checkout A 即可



# git - How can I checkout out the HEAD version of my remote/tracking branch - Stack Overflow
# https://stackoverflow.com/questions/1501149/how-can-i-checkout-out-the-head-version-of-my-remote-tracking-branch/52054278#52054278
#
# checkout branch that HEAD pointed
HEAD_BRANCH="$(git branch -r | grep 'HEAD')"
HEAD_BRANCH="${HEAD_BRANCH#*origin/HEAD -> *origin/}"
git pull; STATUS="$?"; if [ $STATUS -gt "0" ];then git checkout "$HEAD_BRANCH";fi

git pull --all


