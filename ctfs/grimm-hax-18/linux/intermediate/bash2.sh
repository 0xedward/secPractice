#!/bin/bash

: '
Parse URLs in bash!
Constraints:
1. Handle http or https scheme, case insensitive
2. Get the url, without leading or trailing slashes
3. Get the path, with leading slash, but trimming off extra slashes, no path means it is still /
4. Get the params as just "the rest of the url" after the first ? at the end of the path
5. Account for multiple slashes anywhere
6. Do not change the case of any parts!
7. Handle blank path or params including with no trailing slash at the end of the url
'

scheme=""
url=""
path="/"
params=""
index=1
seenTLD=false
#echo "Entire url: $1"
#echo "url length: ${#1}"
#parse until : to get scheme
for i in $(seq ${#1})
do
        char=${1:i-1:1}
        if [ $char == "/" ]; then
                continue
        fi
        #echo "This is char: $char"
        if [ $char == ":" ]; then
                # i+3 to skip ://
                index=$(($i+3))
                break
        else
                scheme+=$char
                # echo $scheme
        fi
done
echo "scheme=$scheme"
#echo "after scheme - current index is $index"

#parse until . and / is found to get url
#for i in $(seq $index ${#1})
for (( index; index <= ${#1}; index++ ))
do
        #echo "This is char: $char"
        #echo "current index: $index"
        char=${1:index-1:1}
        if [ $seenTLD = true ] && [ $char == "/" ]; then
                #bug - url will be fucked if theres any / in between . and path
                index=$index
                break
        else
                if [ $char == "." ]; then
                        seenTLD=true
                fi
        fi
        if [ $char != "/" ]; then
                url+=$char
        fi
done
echo "url=$url"
#echo "after url - current index is $index"

#parse until ? to get path
for (( index; index <= ${#1}; index++ ))
do
        #echo "This is char: $char"
        #echo "current index: $index"
        char=${1:index-1:1}
        if [ $char == "/" ] && [ ${#path} == 1 ]; then
                continue
        fi
        if [ $char == "?" ]; then
                index=$(($index+1))
                break
        fi
        path+=$char
done
#if [ $path == "/" ]; then
#       path=""
#fi
echo "path=$path"
#echo "after path - current index is $index"

#parse until end of string to grab all args
for (( index; index <= ${#1}; index++ ))
do
        char=${1:index-1:1}
        if [ $char != "/" ]; then
                params+=${1:index-1:1}
        fi
done
echo "params=$params"

