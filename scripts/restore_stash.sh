#!/bin/bash

###################
# Is it possible to push a git stash to a remote repository? - Stack Overflow
# https://stackoverflow.com/questions/1550378/is-it-possible-to-push-a-git-stash-to-a-remote-repository
###################

# delete current all stashes
# How to delete a stash created with git stash create? - Stack Overflow
# https://stackoverflow.com/questions/5737002/how-to-delete-a-stash-created-with-git-stash-create
# git stash drop takes no parameter - which drops the top stash - or a stash reference which looks like:
# stash@{n} which n nominates which stash to drop. You can't pass a commit id to git stash drop.
for stash in $(git stash list | cut -d":" -f1 | tac);
    do echo $stash; git stash drop $stash;
done

# force clean unstage files
git clean -f

# get current branch
CURR_BRANCH=$(git branch | grep \* | cut -d" " -f2)

# restore stash from stash_$sha branch
for a in $(git rev-list --no-walk --glob='refs/heads/stash_*' | tac);
    do git checkout $a && git reset HEAD^ && git add . && git stash save "$(git log --format='%s' -1 HEAD@{1})";
done

# checkout current branch
git checkout $CURR_BRANCH

##############
# clean-up stash_$sha branch
##############
# cut(1): remove sections from each line of files - Linux man page
# https://linux.die.net/man/1/cut
# -c, --characters=LIST
#    select only these characters
##############
git branch -D $(git branch|cut -c3-|grep ^stash_)

