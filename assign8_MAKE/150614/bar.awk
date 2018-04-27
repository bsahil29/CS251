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
for(i=1000;i<10000000;i=i*10){
	arr2[i]=arr2[i]/arr1[i];
	arr4[i]=arr4[i]/arr1[i];
	arr8[i]=arr8[i]/arr1[i];
	arr16[i]=arr16[i]/arr1[i];
	arr1[i]=1;

}
for(i=1000;i<10000000;i=i*10){
	print i " " arr1[i] " " arr2[i] " " arr4[i] " " arr8[i] " " arr16[i] > "bar.out"
}

}