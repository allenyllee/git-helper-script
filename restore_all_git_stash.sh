#!/bin/bash

###############################
# usage:
#       ./git-helper-script/restore_all_git_stash.sh [debug]
# ex:
#   test without execute:
#       ./git-helper-script/restore_all_git_stash.sh -d
#   normal execute:
#       ./git-helper-script/restore_all_git_stash.sh
################################

# source directory of this script
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# helper scripts path
SCRIPT_PATH="$SOURCE_DIR/scripts"

DEBUG=$1

$SCRIPT_PATH/loop_for_git_repo.sh " \
    $SCRIPT_PATH/checkout_all_branch.sh\; \
    $SCRIPT_PATH/restore_stash.sh" "$DEBUG"
