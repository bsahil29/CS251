#!usr/bin/gawk
BEGIN{
	
}
{		

	if($2==1){
	arr1[$1]+=$6/100;
	e1[$1]+=($6)*($6)/100;
	}
	if($2==2){
	arr2[$1]+=$6/100;
	e2[$1]+=($6)*($6)/100;
	}
	if($2==4){
	arr4[$1]+=$6/100;
	e4[$1]+=($6)*($6)/100;
	}
	if($2==8){
	arr8[$1]+=$6/100;
	e8[$1]+=($6)*($6)/100;
	}
	if($2==16){
	arr16[$1]+=$6/100;
	e16[$1]+=($6)*($6)/100;
	}
	
}
END{
for(i=1000;i<10000000;i=i*10){
	e1[i]=e1[i]-arr1[i]*arr1[i];
	e2[i]=e2[i]-arr2[i]*arr2[i];
	e4[i]=e4[i]-arr4[i]*arr4[i];
	e8[i]=e8[i]-arr8[i]*arr8[i];
	e16[i]=e16[i]-arr16[i]*arr16[i];
}

for(i=1000;i<10000000;i=i*10){
	e2[i]=e2[i]/(arr2[i]*arr2[i]);
	e4[i]=e4[i]/(arr4[i]*arr4[i]);
	e8[i]=e8[i]/(arr8[i]*arr8[i]);
	e16[i]=e16[i]/(arr16[i]*arr16[i]);
	e1[i]=e1[i]/(arr1[i]*arr1[i]);
	arr2[i]=arr2[i]/arr1[i];
	arr4[i]=arr4[i]/arr1[i];
	arr8[i]=arr8[i]/arr1[i];
	arr16[i]=arr16[i]/arr1[i];
	arr1[i]=1;
}
for(i=1000;i<10000000;i=i*10){
	print i " " arr1[i] " " arr2[i] " " arr4[i] " " arr8[i] " " arr16[i] " " e1[i] " " e2[i] " " e4[i] " " e8[i] " " e16[i] > "error.out"
}

}