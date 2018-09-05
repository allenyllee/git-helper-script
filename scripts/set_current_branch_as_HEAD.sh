#!/bin/bash

# How to get the current branch name in Git? - Stack Overflow
# https://stackoverflow.com/questions/6245570/how-to-get-the-current-branch-name-in-git
# 
# get the name of current branch
CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [ "$CURRENT_BRANCH" != "HEAD" ];then
    # git - How does origin/HEAD get set? - Stack Overflow
    # https://stackoverflow.com/questions/8839958/how-does-origin-head-get-set
    git remote set-head origin "$CURRENT_BRANCH" # auto set remote origin/HEAD
fi

