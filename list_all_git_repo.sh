#!/bin/bash

###############################
# usage:
#       ./git-helper-script/list_all_git_repo.sh [debug]
# ex:
#   test without execute:
#       ./git-helper-script/list_all_git_repo.sh -d
#   normal execute:
#       ./git-helper-script/list_all_git_repo.sh
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

$SCRIPT_PATH/loop_for_git_repo.sh "eval echo \$(pwd)" "$BASE_DIR" "$DEBUG"
