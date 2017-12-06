#!/bin/bash

# git clone all remote branches locally (Example)
# https://coderwall.com/p/0ypmka/git-clone-all-remote-branches-locally

git fetch --all

for branch in $(git branch -a | grep remotes | grep -v HEAD | grep -v master);
    do  echo "$PWD";
        echo "${branch#remotes/*/}";
        git branch --track ${branch#remotes/*/} ${branch};
done
