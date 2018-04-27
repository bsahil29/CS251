#!usr/bin/gawk
BEGIN{
	
}
{
	if( $2 == 1){
		arr1[$0]++;	
	}
	if( $2 == 2){
		arr2[$0]++;	
	}
	if( $2 == 4){
		arr4[$0]++;	
	}
	if( $2 == 8){
		arr8[$0]++;	
	}
	if( $2 == 16){
		arr16[$0]++;	
	}
}
END{
	for(i in arr1){
	for(j=1;j<=arr1[i];j++){
		 print i > "out1.out"
	}
	}
	for(i in arr2){
	for(j=1;j<=arr2[i];j++){
		 print i > "out2.out"
	}
	}
	for(i in arr4){
	for(j=1;j<=arr4[i];j++){
		 print i > "out4.out"
	}
	}
	for(i in arr8){
	for(j=1;j<=arr8[i];j++){
		 print i > "out8.out"
	}
	}
	for(i in arr16){
	for(j=1;j<=arr16[i];j++){
		 print i > "out16.out"
	}
	}


}