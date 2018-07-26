#!/bin/bash

###############
# Is it possible to push a git stash to a remote repository? - Stack Overflow
# https://stackoverflow.com/questions/1550378/is-it-possible-to-push-a-git-stash-to-a-remote-repository
###############

filename=$(basename $0)
REPO_URL=$1


echo "$filename REPO_URL=$REPO_URL"

# push stash as branch stash_$sha to remote
git push $REPO_URL $(for sha in $(git rev-list -g stash); \
    do echo $sha:refs/heads/stash_$sha; done)
