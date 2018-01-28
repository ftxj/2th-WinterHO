#!/bin/bash
#programe
#	This program will cacluate a number's factodrial
#History
#2016.4.3 first shell script
factorial () {
	local num=$1
	if [ "$num" == "0" ];then
		sum=1
	else
		factorial $((num-1))
		sum=$((num*sum))
	fi
	return $sum
}
if [ "$1" != "" ];then
	factorial $1
	echo $?
	exit 1
else 
	echo "usage ./sh01.sh [n]"
	echo "caculate a number's factorial"
	exit 1
fi

