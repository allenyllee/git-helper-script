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


# git - How does origin/HEAD get set? - Stack Overflow
# https://stackoverflow.com/questions/8839958/how-does-origin-head-get-set
# 
# if there are no remote origin/HEAD was set
if [ -z "$HEAD_BRANCH"  ];then
    git remote set-head origin -a # auto set remote origin/HEAD
    HEAD_BRANCH="$(git branch -r | grep 'HEAD')"
    HEAD_BRANCH="${HEAD_BRANCH#*origin/HEAD -> *origin/}"
fi

# How to get the current branch name in Git? - Stack Overflow
# https://stackoverflow.com/questions/6245570/how-to-get-the-current-branch-name-in-git
# 
# get the name of current branch
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [ "$CURRENT_BRANCH" == "HEAD" ];then git checkout "$HEAD_BRANCH";fi

# How to see which git branches are tracking which remote / upstream branch? - Stack Overflow
# https://stackoverflow.com/questions/4950725/how-to-see-which-git-branches-are-tracking-which-remote-upstream-branch/10035630#10035630
# 
# get upstream name
UPSTREAM="$(git rev-parse --abbrev-ref "$HEAD_BRANCH"@{upstream})"
if [ -z "$UPSTREAM" ];then git branch --set-upstream-to=origin/"$HEAD_BRANCH" "$HEAD_BRANCH";fi


git pull --all


