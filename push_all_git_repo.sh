#!/bin/bash

###############################
# usage:
#       ./git-helper-script/push_all_git_repo.sh [access_token] [remote_provider] [username] [debug]
# ex:
#   test without execute:
#       ./git-helper-script/push_all_git_repo.sh 1234abcd gitlab yourname -d
#   normal execute:
#       ./git-helper-script/push_all_git_repo.sh 1234abcd gitlab yourname
################################

# source directory of this script
SOURCE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# base dir of this script to exclude
BASE_DIR="$(basename $SOURCE_DIR)"
# helper scripts path
SCRIPT_PATH="$SOURCE_DIR/scripts"

TOKEN=$1
SITE=$2
USER=$3
DEBUG=$4

REPO_NAME="\${PWD##*/}"
DEFAULT_BRANCH="git-svn2"


case $SITE in
gitlab)
    REMOTE_URL="https://gitlab.com/$USER"
    API="https://gitlab.com/api/v4/projects?name=$REPO_NAME\&visibility=private\&default_branch=$DEFAULT_BRANCH"
;;
github)
    REMOTE_URL=
    API=
;;
esac

REPO_URL="$REMOTE_URL/$REPO_NAME.git/"

$SCRIPT_PATH/loop_for_git_repo.sh " \
    $SCRIPT_PATH/create_git_remote.sh $TOKEN $API\; \
    $SCRIPT_PATH/push_git_repo.sh $REPO_URL\; \
    $SCRIPT_PATH/push_git_stash.sh $REPO_URL\; \
    $SCRIPT_PATH/output_result.sh $SOURCE_DIR '$DEFAULT_BRANCH\ $REPO_URL'" "$BASE_DIR" "$DEBUG"
