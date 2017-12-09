#!/bin/bash

COMMAND=$1
EXCLUDE=$2
DEBUG=$3


echo "$EXCLUDE"

# directory - Listing only directories using ls in bash: An examination - Stack Overflow
# https://stackoverflow.com/questions/14352290/listing-only-directories-using-ls-in-bash-an-examination
# Note that */ won't match any hidden folders. To include them, either specify them explicitly like ls -d .*/ */

# Negative matching using grep (match lines that do not contain foo) - Stack Overflow
# https://stackoverflow.com/questions/3548453/negative-matching-using-grep-match-lines-that-do-not-contain-foo
#  forcing grep to interpret the pattern as an extended regular expression using -E works, i.e. grep -vE 'negphrase1|negphrase2|negphrase3'

loopforall(){
    level_loopforall=$(($level_loopforall+1))
    if [ $level_loopforall -eq 1 ]; then
        echo "****************** level 0 ******************";
    fi

    local ret_loopforall=0
    local tmp_loopforall=0

    local OLD_IFS=$IFS     # Stores Default IFS
    IFS=$'\n'        # Set it to line break

    for dir in $(ls -a -d */ 2>/dev/null | grep -vE "$EXCLUDE" 2>/dev/null);
        do  #echo "current dir is $dir and parent dir is $2";
            #echo "before ret=$ret_loopforall tmp=$tmp_loopforall";
            cd "$dir" && $1; tmp_loopforall=$?; cd $2 >/dev/null;
            ret_loopforall=`expr $ret_loopforall + $tmp_loopforall`;
            #echo "after ret=$ret_loopforall tmp=$tmp_loopforall";
    done

    IFS=$OLD_IFS

    if [ $level_loopforall -eq 1 ]; then
        echo "****************** end of level 0 ***********";
        echo "total number: $ret_loopforall"
    fi
    level_loopforall=$(($level_loopforall-1))

    return $ret_loopforall
}

# linux - Using grep to search for a string that has a dot in it - Stack Overflow
# https://stackoverflow.com/questions/10346816/using-grep-to-search-for-a-string-that-has-a-dot-in-it
# you'll need to use \\. for bash too, or use "\." to escape it from the shell.

searchgit(){
    level_searchgit=$(($level_searchgit+1))
    #if [ -z "$level_searchgit" ]; then
    #    level_searchgit=$(($level_searchgit+1))
    #    #echo "========= level $level_searchgit =============="
    #fi

    #if [ $level_searchgit -eq 1 ]; then
    #    echo "========= level $level_searchgit =============="
    #fi

    local ret_searchgit=0

    if [ -n "$(ls -a | grep \\.git)" ];
    then

        #echo "========= level $level_searchgit =============="

        if [ -n "$(ls -a | grep \\.gitmodules)" ]; then
            #level_searchgit=$(($level_searchgit+1))

            #if [ $level_searchgit -gt 1 ]; then
            #    echo "========= level $level_searchgit =============="
            #fi
            #local tmp=$level_searchgit
            echo "========= level $(($level_searchgit)) =============="
            loopforall searchgit "$(pwd)"
            ret_searchgit=$?
            echo "ret_searchgit=$ret_searchgit"
            #if [ $level_searchgit -eq $tmp ]; then
            #    echo "========= end of level $level_searchgit =============="
            #fi
            #if [ $level_searchgit -gt 1 ]; then
            #    echo "ret_searchgit=$ret_searchgit"
            #    echo "========= end of level $(($level_searchgit)) ======="
            #fi
            echo "========= end of level $(($level_searchgit)) ======="
            #level_searchgit=$(($level_searchgit-1))
        fi

        #if [ $level_loopforall -eq 1 ]; then
        #    echo "========= level $level_searchgit =============="
        #fi

        if [ "$DEBUG" == "-d" ];
        then
            #echo "current dir is $PWD"
            echo $(eval echo "$COMMAND")
        else
            eval $(eval echo "$COMMAND")
        fi
        #ret_searchgit=1
        ret_searchgit=$(($ret_searchgit+1))

        #if [ $level_searchgit -eq 1 ]; then
        #    echo "ret_searchgit=$ret_searchgit"
        #    echo "========= end of level $level_searchgit =============="
        #fi


        if [ $level_loopforall -eq 1 ]; then
            #echo "ret_searchgit=$ret_searchgit"
            #echo "========= end of level $level_searchgit =============="
            echo "";
        fi

        level_searchgit=$(($level_searchgit-1))
        return $ret_searchgit
    else

        if [ $level_searchgit -eq 1 ]; then
            echo "========= level $level_searchgit =============="
        fi

        loopforall searchgit "$(pwd)"
        ret_searchgit=$?

        #echo "ret_searchgit=$ret_searchgit"
        #echo "========= end of level $level_searchgit ======="

        if [ $level_searchgit -eq 1 ]; then
            echo "ret_searchgit=$ret_searchgit"
            echo "========= end of level $level_searchgit ======="
            echo "";
        fi


        level_searchgit=$(($level_searchgit-1))
        return $ret_searchgit
    fi
}

echo ""

loopforall searchgit "$(pwd)"