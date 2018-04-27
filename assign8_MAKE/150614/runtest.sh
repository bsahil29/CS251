#!/bin/bash
#rm output
for num_elements in $(cat params.txt);
do
    for num_threads in $(cat threads.txt);
    do
    	for i in {1..100}; 
    	do 
       		echo -n $num_elements  >> output
       		echo -n ' ' >> output
       		echo -n $num_threads  >> output
       		echo -n ' ' >> output
       		./App.ex1 $num_elements $num_threads  >> output

       	done
    done
done
