split -l 9 "$1" phase2-
i=00
temp=$(ls phase2-*)
# echo $temp
for file in $temp
do
	tmp="phase2-"
	tmp+="$i"
	mv "$file" "$tmp"
	i=$(($i+1))
done

