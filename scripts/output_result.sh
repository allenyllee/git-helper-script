#!/bin/bash

OUTPUT_PATH=$1
RESULT=$2

echo "git submodule add -b "$RESULT"" >> $OUTPUT_PATH
