#!/bin/bash

filename=$(basename $0)
TOKEN=$1
API=$2

echo "$filename TOKEN=$TOKEN API=$API"
curl -s --header "PRIVATE-TOKEN: $TOKEN" -X POST "$API"
echo ""
echo ""
echo ""
