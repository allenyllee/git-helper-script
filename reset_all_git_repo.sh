#!/bin/bash

###############################
# usage:
#       ./git-helper-script/reset_all_git_repo.sh [debug]
# ex:
#   test without execute:
#       ./git-helper-script/reset_all_git_repo.sh -d
#   normal execute:
#       ./git-helper-script/reset_all_git_repo.sh
################################

# shell - How to get the last part of dirname in Bash - Stack Overflow
# https://stackoverflow.com/questions/23162299/how-to-get-the-last-part-of-dirname-in-bash
# You can use basename even though it's not a file. Strip off the file name using dirname,
# then use basename to get the last element of the string:

# source directory of this script
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# base dir of this script to exclude
BASE_DIR="$(basename $SOURCE_DIR)"
# helper scripts path
SCRIPT_PATH="$SOURCE_DIR/scripts"

DEBUG=$1


#########
# Smudge filter failed with a fresh new clone · Issue #911 · git-lfs/git-lfs
# https://github.com/git-lfs/git-lfs/issues/911
#
# #Skip smudge - We'll download binary files later in a faster batch
# git lfs install --skip-smudge
#
# #Do git clone here
# git clone ...
#
# #Fetch all the binary files in the new clone
# git lfs pull
#
# #Reinstate smudge
# git lfs install --force
#########

git lfs install --skip-smudge

# execute
$SCRIPT_PATH/loop_for_git_repo.sh "git reset --hard HEAD\; git lfs pull" "$BASE_DIR" "$DEBUG"

git lfs install --force