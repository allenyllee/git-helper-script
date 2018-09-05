#!/bin/bash

COMMAND="$1"
EXCLUDE="$2"
DEBUG="$3"


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

    #
    # Local Variables
    # http://tldp.org/LDP/abs/html/localvar.html
    #
    local ret_loopforall=0
    local tmp_loopforall=0


    #
    #  BASH Shell: For Loop File Names With Spaces – nixCraft
    # https://www.cyberciti.biz/tips/handling-filenames-with-spaces-in-bash.html
    #
    local OLD_IFS=$IFS     # Stores Default IFS
    IFS=$'\n'        # Set it to line break

    for dir in $(ls -a -d */ 2>/dev/null | grep -vE "$EXCLUDE" 2>/dev/null);
        do  #echo "current dir is $dir and parent dir is $2";
            #echo "before ret=$ret_loopforall tmp=$tmp_loopforall";
            cd "$dir" && $1; tmp_loopforall=$?; cd $2 >/dev/null;
            # Linux bash. for loop and function, for adding numbers - Stack Overflow
            # https://stackoverflow.com/questions/22460266/linux-bash-for-loop-and-function-for-adding-numbers
            ret_loopforall=`expr $ret_loopforall + $tmp_loopforall`;
            #echo "after ret=$ret_loopforall tmp=$tmp_loopforall";
    done

    IFS=$OLD_IFS

    if [ $level_loopforall -eq 1 ]; then
        echo ""
        echo "****************** end of level 0 ***********";
        echo "total number: $ret_loopforall"
    fi

    # How can I add numbers in a bash script - Stack Overflow
    # https://stackoverflow.com/questions/6348902/how-can-i-add-numbers-in-a-bash-script
    level_loopforall=$(($level_loopforall-1))

    # How to modify a global variable within a function in bash? - Stack Overflow
    # https://stackoverflow.com/questions/23564995/how-to-modify-a-global-variable-within-a-function-in-bash
    return $ret_loopforall
}

# linux - Using grep to search for a string that has a dot in it - Stack Overflow
# https://stackoverflow.com/questions/10346816/using-grep-to-search-for-a-string-that-has-a-dot-in-it
# you'll need to use \\. for bash too, or use "\." to escape it from the shell.
searchgit(){
    level_searchgit=$(($level_searchgit+1))

    local ret_searchgit=0

    # shell - How to make grep only match if the entire line matches? - Stack Overflow
    # https://stackoverflow.com/questions/4709912/how-to-make-grep-only-match-if-the-entire-line-matches
    # Both anchors (^ and $) are needed.
    if [ -n "$(ls -a | grep '^.git$' )" ];then

        if [ -n "$(ls -a | grep \\.gitmodules)" ]; then
            echo "parent dir: "$(pwd)""
            echo "========= level $(($level_searchgit)) =============="
            loopforall searchgit "$(pwd)"
            ret_searchgit=$?
            echo "ret_searchgit=$ret_searchgit"
            echo "========= end of level $(($level_searchgit)) ======="
        fi

        if [ "$DEBUG" == "-d" ];
        then
            #echo "current dir is $PWD"
            echo $(eval echo "$COMMAND")
        else
            echo "current dir is $PWD"
            eval $(eval echo "$COMMAND")
        fi

        ret_searchgit=$(($ret_searchgit+1))

        level_searchgit=$(($level_searchgit-1))
        return $ret_searchgit
    else

        if [ $level_searchgit -eq 1 ]; then
            echo "parent dir: "$(pwd)""
            echo "========= level $level_searchgit =============="
        fi

        loopforall searchgit "$(pwd)"
        ret_searchgit=$?

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