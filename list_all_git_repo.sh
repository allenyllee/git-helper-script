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

# source directory of this script
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# base dir of this script to exclude
BASE_DIR="$(basename $SOURCE_DIR)"
# helper scripts path
SCRIPT_PATH="$SOURCE_DIR/scripts"

DEBUG=$1

$SCRIPT_PATH/loop_for_git_repo.sh "eval echo \$(pwd)" "$BASE_DIR" "$DEBUG"
