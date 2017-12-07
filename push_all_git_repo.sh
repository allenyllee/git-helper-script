#!/bin/bash

###############################
# usage:
#       ./git-helper-script/push_all_git_repo.sh [access_token] [remote_provider] [username] [default_branch] [output_file] [debug]
# ex:
#   test without execute:
#       ./git-helper-script/push_all_git_repo.sh 1234abcd gitlab yourname new_branch output.txt -d
#   normal execute:
#       ./git-helper-script/push_all_git_repo.sh 1234abcd gitlab yourname new_branch output.txt
################################

# source directory of this script
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# base dir of this script to exclude
BASE_DIR="$(basename $SOURCE_DIR)"
# helper scripts path
SCRIPT_PATH="$SOURCE_DIR/scripts"

# parameter
TOKEN=$1
SITE=$2
USER=$3
DEFAULT_BRANCH=$4
OUTPUT_FILE=$5
DEBUG=$6

# set output path
OUTPUT_PATH="$SOURCE_DIR/$OUTPUT_FILE"

# repo name is evaluated when loop into git folder
REPO_NAME="\${PWD##*/}"

# select remote provider
case $SITE in
gitlab)
    REMOTE_URL="https://gitlab.com/$USER"
    API="https://gitlab.com/api/v4/projects"
;;
github)
    REMOTE_URL=
    API=
;;
esac

# set repo url
REPO_URL="$REMOTE_URL/$REPO_NAME.git/"

# remove previous output file
rm -rf $OUTPUT_PATH

# execute
$SCRIPT_PATH/loop_for_git_repo.sh " \
    $SCRIPT_PATH/create_git_remote.sh $TOKEN $API $REPO_NAME $DEFAULT_BRANCH\; \
    $SCRIPT_PATH/push_git_repo.sh $REPO_URL\; \
    $SCRIPT_PATH/push_git_stash.sh $REPO_URL\; \
    $SCRIPT_PATH/output_result.sh $OUTPUT_PATH \'$DEFAULT_BRANCH\ $REPO_URL\'" "$BASE_DIR" "$DEBUG"
