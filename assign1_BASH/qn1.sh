#!/bin/bash
#0 <= N <=9999,99,99,999
function ones()
{
  case "$1" in
1)
  output+="one"
  ;;
2)
  output+="two"
  ;;
3)
  output+="three"
  ;;
4)
  output+="four"
  ;;
5)
  output+="five"
  ;;
6)
  output+="six"
  ;;
7)
  output+="seven"
  ;;
8)
  output+="eight"
  ;;
9)
  output+="nine"
  ;;
esac
}
function twos()
{
if [ $1 -le 9 ]
then ones "$1"
elif [ $1 -gt 9 ] && [ $1 -lt 20 ];
  then 
    case "$1" in
    10)
    output+="ten"
    ;;
    11)
    output+="eleven"
    ;;
    12)
    output+="twelve"
    ;;
    13)
    output+="thirteen"
    ;;
    14)
    output+="fourteen"
    ;;
    15)
    output+="fifteen"
    ;;
    16)
    output+="sixteen"
    ;;  
    17)
    output+="seventeen"
    ;;
    18)
    output+="eighteen"
    ;;
    19)
    output+="nineteen"
    ;;
    esac
  else
    if [ $1 -ge 20 ] && [ $1 -lt 30 ]
      then
      output+="twenty "
      ones $(($1%10))
    elif [ $1 -ge 30 ] && [ $1 -lt 40 ]
      then
      output+="thirty "
      ones $(($1%10))
    elif [ $1 -ge 40 ] && [ $1 -lt 50 ]
      then
      output+="forty "
      ones $(($1%10))
    elif [ $1 -ge 50 ] && [ $1 -lt 60 ]
      then
      output+="fifty "
      ones $(($1%10))
    elif [ $1 -ge 60 ] && [ $1 -lt 70 ]
      then
      output+="sixty "
      ones $(($1%10))
    elif [ $1 -ge 70 ] && [ $1 -lt 80 ]
      then
      output+="seventy "
      ones $(($1%10))
    elif [ $1 -ge 80 ] && [ $1 -lt 90 ] 
      then
      output+="eighty "
      ones $(($1%10))
    elif [ $1 -ge 90 ] && [ $1 -lt 100 ]
      then
      output+="ninty "
      ones $(($1%10))
    fi 
  fi
}
function threes()
{
  if [ $1 -gt 99 ]
  then
    ones $(($1/100))
    output+=" hundred "
    twos $(($1%100))
  else
    twos $(($1%100))
  fi

}
function fours()
{
  ones $(($1/1000))
  output+=" thousand "
  threes $(($1%1000))
}
function fives()
{
  if [ $1 -gt 999 ]
    then
    twos $(($1/1000))
    fours $(($1%1000))
  else
    threes $1
  fi
}
function sixes()
{
  ones $(($1/100000))
  output+=" lakh "
  if ! [ $(($1%100000)) -eq 0 ]
    then
    fives $(($1%100000))
  fi
}
function sevens()
{
  if [ $1 -gt 99999 ]
    then 
      twos $(($1/100000))
      output+=" lakhs "
      if ! [ $(($1%100000)) -eq 0 ]
      then
      fives $(($1%100000))
    fi
  else
    fives $1
  fi
}
function eights()
{
  ones $(($1/10000000))
  output+=" crore "
  if ! [ $(($1%100000)) -eq 0 ]
    then
    sevens $(($1%10000000))
  fi
}
function nines()
{
  twos $(($1/10000000))
  output+=" crores "
  if ! [ $(($1%100000)) -eq 0 ]
    then
    sevens $(($1%10000000))
  fi
}
function tens()
{
  threes $(($1/10000000))
  if ! [ $(($1%10000000)) -eq 0 ]
    then
    nines $(($1%10000000))
  fi
}
function elevens()
{
  fours $(($1/10000000))
  if ! [ $(($1%10000000)) -eq 0 ]
    then
    nines $(($1%10000000))
  fi
}
read entry

#if anything else than integers
regex='^[0-9]+$'
if ! [[ $entry =~ $regex ]]
then 
  echo "invalid input"
  exit -1
fi
#getting rid of leading zeros
input=$(echo $entry | sed 's/^0*//')




#if negative number
#if [ $input -lt 0 ]
#then 
#	echo "invalid input"
#	exit -1
#fi
#if input is zero
#if [ $input -eq 0 ]
#then 
 # echo "zero"
 # exit -1
#fi


#number of digits in input
digits=${#input};

#if number of digits is greater than 11
if [ $digits -gt 11 ]
then
	echo "invalid input"
	exit -1
fi

#if input is zero
if [ $digits -eq 0 ]
then 
  echo "zero"
  exit -1
fi

#what is output finally
output=""
#different function calls for different number of digits in input
case $((digits)) in
1)
  ones $input 
  ;;
2)
  twos $input
  ;;
3)
  threes $input
  ;;
4)
  fours $input
  ;;
5)
  fives $input
  ;;
6)
  sixes $input
  ;;
7)
  sevens $input
  ;;
8)
  eights $input
  ;;
9)
  nines $input
  ;;
10)
  tens $input
  ;;
11)
  elevens $input
  ;;
esac
#final output
echo $output