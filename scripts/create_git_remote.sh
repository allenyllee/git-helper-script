#!/bin/bash

filename=$(basename $0)

TOKEN=$1
API=$2
REPO_NAME=$3
DEFAULT_BRANCH=$4

echo "$filename TOKEN=$TOKEN API=$API"


# get project id
PROJECT_ID=$(curl -s --header "PRIVATE-TOKEN: $TOKEN" -X POST "$API?name=$REPO_NAME&visibility=private")
echo "$PROJECT_ID"
PROJECT_ID=$(echo "$PROJECT_ID" | cut -d"," -f1 | cut -d":" -f2 )
echo "$PROJECT_ID"
echo ""

# create default branch
curl -s --header "PRIVATE-TOKEN: $TOKEN" -X POST "$API/$PROJECT_ID/repository/branches?branch=$DEFAULT_BRANCH&ref=master"
echo ""
echo ""

# set default branch
curl -s --header "PRIVATE-TOKEN: $TOKEN" -X PUT "$API/$PROJECT_ID?default_branch=$DEFAULT_BRANCH"
echo ""
echo ""

# end
echo ""
