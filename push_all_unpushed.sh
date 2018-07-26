#!/bin/bash

# source directory of this script
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# base dir of this script to exclude
BASE_DIR="$(basename $SOURCE_DIR)"
# helper scripts path
SCRIPT_PATH="$SOURCE_DIR/scripts"

DEBUG=$1

# execute
$SCRIPT_PATH/loop_for_git_repo.sh "git push --all" "$BASE_DIR" "$DEBUG"