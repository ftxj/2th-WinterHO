#!/bin/bash
look () {
	echo "NIC 	IP Address"
	ifconfig -a > lingshi
	cat lingshi | grep 'inet addr' | cut -d ':' -f 2 > lingshi1
	cat lingshi1 | cut -d ' ' -f 1 > lingshi3
	cat lingshi | grep 'Link' | cut -d ' ' -f 1 > lingshi2
	cat lingshi2 | cut -d 'l' -f 1,2 | sed '2d' > lingshi4
	paste lingshi4 lingshi3
	rm lingshi
	rm lingshi1
	rm lingshi2
	rm lingshi4
	rm lingshi3
}
if [ "$1" == "" ];then
	look
elif [ "$1" == "-ip" ];then
	if [[ $2 =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]];then
		if [ "$3" == "-mask" ];then
			if [[ $4 =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]];then
				ifconfig eth0 $2 netmask $4
				look
			else
				echo "USage: ./myip.sh [ ] or [-ip ADDR] [-mask MASK]"
			fi
		elif [ "$3" == "" ];then
			ifconfig eth0 $2
			look
		else
			echo "USage: ./myip.sh [ ] or [-ip ADDR] [-mask MASK]"
		fi
	else
		echo "USage: ./myip.sh [ ] or [-ip ADDR] [-mask MASK]"
	fi
elif [ "$1" == "-mask" ];then
	if [[ $2 =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]];then
		if [ "$3" == "-ip" ];then
			if [[ $4 =~ [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} ]];then
				ifconfig eth0 $4 netmask $2
				look
			else
				echo "USage: ./myip.sh [ ] or [-ip ADDR] [-mask MASK]"
			fi
		elif [ "$3" == "" ];then
			ifconfig netmask $2
			look
		else
			echo "USage: ./myip.sh [ ] or [-ip ADDR] [-mask MASK]"
		fi
	else
		echo "USage: ./myip.sh [ ] or [-ip ADDR] [-mask MASK]"
	fi
else
	echo "USage: ./myip.sh [ ] or [-ip ADDR] [-mask MASK]"
fi
exit 1
