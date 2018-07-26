#!/bin/bash

filename=$(basename $0)
REPO_URL=$1

echo "$filename REPO_URL=$REPO_URL"

git remote remove temp
git remote add temp $REPO_URL
#echo "debug1"
git push temp -f --all
#echo "debug2"
git push temp -f --tags

git remote remove temp

echo ""
echo ""
