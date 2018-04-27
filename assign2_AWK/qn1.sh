#!/bin/bash
traversedir(){
	for file in "$1"/*
	do
		if [[ -f $file ]]
			then
				awk -f qn1.awk $file >> output.txt
		elif [[ -d $file ]]; 
			then
				traversedir $file		
		fi				
	done
}
traversedir $1
awk 'BEGIN{sum1=0;sum2=0}{sum1=sum1+$1;sum2=sum2+$2}END{print sum1," lines of comments";print sum2," strings"}' output.txt