filename="rashis.txt"
i=00
while read -r line
do
    temp=$(cat phase2-$i)
    echo -n $line
    echo -n ":"
    rm out
    rm out1
    # sed ':a;N;$!ba;s/\n/ /g' nakshatras.txt > nak   
	awk '{arr[$1]++}END{for(i in arr){print i,arr[i]}}' phase2-$i >> out
    # echo hello >> out
    awk '{getline b < "out" ;print $0,b;}' nakshatras.txt >> out1
     #cat $out1 | wc -l
    # rm out
    # awk -f out.awk out
    i=$(($i+1))
done < "$filename"