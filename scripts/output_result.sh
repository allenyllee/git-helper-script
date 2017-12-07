#!/bin/bash

OUTPUT_DIR=$1
RESULT=$2

echo "git submodule add -b "$RESULT"" >> $OUTPUT_DIR/output.txt
