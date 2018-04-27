#! /bin/bash
read_file()
{
  #local IFS=\>
  #read -d "<" Keyi Valuei
  if [[ "$2" ]]; then
    #echo "iii"
    if [[ "$dir_flag" -eq 1  ]]; then
     # echo "1"
      mkdir "$2"
      cd "$2"
    elif [[ "$file_flag" -eq 1 ]]; then
        if [[ "$1" == "<name>" ]]; then
          Name=$2
          #echo $Name
        elif [[ "$1" == "<size>" ]]; then
          Size=$2 
          fallocate -l $Size $Name 
        fi
    fi 
  else
    if [[ "$1" == "<dir>" ]]; then
     #echo "2"
      dir_flag=1
      file_flag=0
      dir=$((dir+1))
    elif [[ "$1" == "<file>" ]]; then
      dir_flag=0
      file_flag=1
           
    elif [[ "$1" ==  "</dir>" ]]; then
      dir=$((dir-1)) 
      cd ..
    fi
 fi
 
  
}

sed -i -e 's/</ </g' $1
sed -i -e 's/>/> /g' $1
dir_flag=0
file_flag=0
dir=0
#echo "inside"
readarray -t lines < "$1"

#echo "put"
for line in "${lines[@]}"; do
   read_file $line
   #echo "in" 
done
sed -i -e 's/ </</g' $1
sed -i -e 's/> />/g' $1
