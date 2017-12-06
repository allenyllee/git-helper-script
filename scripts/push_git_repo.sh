#!/bin/bash

filename=$(basename $0)
REPO_URL=$1

echo "$filename REPO_URL=$REPO_URL"

git remote remove gitlab
git remote add gitlab $REPO_URL
#echo "debug1"
git push gitlab --all
#echo "debug2"
git push gitlab --tags

echo ""
echo ""
