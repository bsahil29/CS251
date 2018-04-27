#!/bin/bash
#relative path is input 
read input
#counting number of slashes in input directory to keep track of indentation
y=`echo "$(pwd)/$input" | grep -o "\/" |wc -l`;
y=$(($y - 1))
#counting number of sentences in a file
function numberofsentences()
{
    local num=`cat "$1" | egrep '(\?|[^0-9]\.|\.[^0-9]|\.$|!)' -o | wc -l`
    return $num;
}
#counting number of integers in a file
function numberofintegers()
{
    local count=0;
    for expr in $(cat "$1")
    do
        if [[ "$expr" =~ ^-?[0-9]+[\.]?$ ]]
        then
            (( count+=1 ))
        fi
    done
    return $count;
}
#counting number of sentences in a directory
function numsentdir()
{
    local count=0;
    for file in "$1"/*
    do 
        if [[ -d "$file" ]]
        then
            numsentdir "$file"
            (( count+=$? ))
        else
            numberofsentences "$file"
            (( count+=$? ))
        fi
    done
    return $count;
}
#counting number of integers in a directory
function numintdir()
{
    local count=0;
    for files in "$1"/*
    do 
        if [[ -d "$files" ]]
        then
            numintdir "$files"
            (( count+=$? ))
        else
            numberofintegers "$files"
            (( count+=$? ))
        fi
    done
    return $count;
}
#main function to list the number of sentences and number of integers for all the files and subdirectories with proper indentation
function listingfiles()
{
    cd "$1";
    for i in *;
    do 
    if [[ -d "$i" ]]
    then
        x=`echo "$(pwd)" | grep -o "\/" |wc -l`;
        (( x-=$y ))
         while [  $x -gt 0 ]; do
             echo -n -e "\t"
             (( x-=1 ))
         done
        echo -n "(D) $i-"
        numsentdir "$i"
        echo -n $?-
        numintdir "$i"
        echo $? 
	    listingfiles "$i"
        cd ..        
    else
        x=`echo "$(pwd)" | grep -o "\/" |wc -l`;
        (( x-=$y ))
        while [  $x -gt 0 ]; do
             echo -n -e "\t"
             (( x-=1 )) 
         done
	    echo -n "(F) $i-"
        numberofsentences "$i"
        echo -n $?-
        numberofintegers "$i"
        echo $?
    fi
    done
}
#function call to listingfiles() function which lists the num of sentences and num of integers for all files and subdirectories
listingfiles "$input"
echo -n "(D) $input-"
#calculating number of sentences for original directory entered
numsentdir "$(pwd)"
echo -n $?-
#counting number of integers for original directory entered
numintdir "$(pwd)"
echo $?