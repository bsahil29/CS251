#!usr/bin/gawk
BEGIN{
	
}
{		

	if($2==1){
	arr1[$1]+=$6/100;
	}
	if($2==2){
	arr2[$1]+=$6/100;
	}
	if($2==4){
	arr4[$1]+=$6/100;
	}
	if($2==8){
	arr8[$1]+=$6/100;
	}
	if($2==16){
	arr16[$1]+=$6/100;
	}
	
}
END{
for(i in arr1){
	print  i " " arr1[i] > "line1.out"
}
for(i in arr2){
	print  i " " arr2[i] > "line2.out"
}
for(i in arr4){
	print  i " " arr4[i] > "line4.out"
}
for(i in arr8){
	print  i " " arr8[i] > "line8.out"
}
for(i in arr16){
	print  i " " arr16[i] > "line16.out"
}

}