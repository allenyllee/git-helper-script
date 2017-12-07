#!/bin/bash

COMMAND=$1
EXCLUDE=$2
DEBUG=$3


# directory - Listing only directories using ls in bash: An examination - Stack Overflow
# https://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash-an-examination
# Note that */ won't match any hidden folders. To include them, either specify them explicitly like ls -d .*/ */

loopforall(){
    for dir in $(ls -a -d */ | grep -v "$EXCLUDE" 2>/dev/null);
        do  #echo "current dir is $dir and parent dir is $2";
            cd $dir && $1; cd $2 >/dev/null;
    done
}

# linux - Using grep to search for a string that has a dot in it - Stack Overflow
# https://stackoverflow.com/questions/10346816/using-grep-to-search-for-a-string-that-has-a-dot-in-it
# you'll need to use \\. for bash too, or use "\." to escape it from the shell.

searchgit(){
    if [ -n "$(ls -a | grep \\.git)" ];
    then
        if [ "$DEBUG" == "-d" ];
        then
            echo "current dir is $PWD"
            echo $(eval echo "$COMMAND")
        else
            eval $(eval echo "$COMMAND")
        fi
        echo ""
        echo "============="
        echo ""
    else
        loopforall searchgit "$(pwd)"
    fi
}

loopforall searchgit "$(pwd)"
