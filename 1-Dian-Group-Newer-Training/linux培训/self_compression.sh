#!/bin/bash
if [ -z $1 ];then
	echo "usage:  ./self_compression.sh [--list] or [source compressed file]  [destination path]"
	echo "self compression according to the file name suffix"
	exit 1
elif [ "$1" == "--list" ];then
	echo "Support file types : zip tar.gz tar.bz2"
	exit 1
elif [[ $1 =~ .*\.zip ]];then
	tar -xv -f $1
	exit 1
elif [[ $1 =~ .*\.tar\.gz ]];then
	tar -zxv -f $1
	exit 1
elif [[ $1 =~ .*\.tar\.bz2 ]];then
	tar -jxv -f $1
	exit 1
else 
	echo "can't invisible"
	exit 1
fi
