#!/bin/bash

COMMAND=$1
DEBUG=$2

# directory - Listing only directories using ls in bash: An examination - Stack Overflow
# https://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash-an-examination
# Note that */ won't match any hidden folders. To include them, either specify them explicitly like ls -d .*/ */

loopforall(){
    for dir in $(ls -a -d */ 2>/dev/null);
        do  #echo "current dir is $dir and parent dir is $2";
            cd $dir && $1; cd $2 >/dev/null;
    done
}

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
