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
# GitLab API - GitLab Documentation
# https://docs.gitlab.com/ce/api/README.html#personal-access-tokens
# Example of using the personal access token in a header:
# curl --header "Private-Token: 9koXpg98eAheJpvBs5tK" https://gitlab.example.com/api/v4/projects
################################
# Personal access tokens - GitLab Documentation
# https://docs.gitlab.com/ce/user/profile/personal_access_tokens.html#personal-access-tokens
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
# shell - Get current directory name (without full path) in a Bash script - Stack Overflow
# https://stackoverflow.com/questions/1371261/get-current-directory-name-without-full-path-in-a-bash-script
# No need for basename, and especially no need for a subshell running pwd (which adds an extra, and expensive, fork operation); the shell can do this internally using parameter expansion:
REPO_NAME="\${PWD##*/}"

# select remote provider
case $SITE in
gitlab)
    # GitLab API - GitLab Documentation
    # https://docs.gitlab.com/ce/api/README.html#namespaced-path-encoding
    API="https://gitlab.com/api/v4/projects"
    REMOTE_URL="https://gitlab.com/$USER"
;;
github)
    API=
    REMOTE_URL=
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
