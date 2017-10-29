#!/bin/bash 
##start Local net Cheking
var1=`ip addr | grep brd | wc -l`
var2=`ip addr | awk {'print $1'} | grep : | wc -l`
if [ "$var1" == "$var2" ];then
	echo -e "\033[91m[-]Your Are Offline!!!"
	exit 1
else
	echo -e "\033[92m[+]Your Local Netowkr Is Ok!."
##start internet Checking
	ping -c2 -w2 8.8.8.8 1>/dev/null 2>/dev/null
	if [ "$?" != "0" ];then
		echo -e "\033[91m[-]You Have Internet ERROR! CHECK THAT."
		exit 1
	else
		echo -e "\033[92m[+]Your Internet Is OK!"
		##Start DNS Checking
		nslookup gnu.org -timeout=1 1>/dev/null 2>/dev/null 
		if [ "$?" != "0" ];then
			echo -e "\033[91m[-]You Have Dns ERROR! "
			read -p "I cat To Ok That, Do You Want To Contniue?[Y/n] " yesorno
			if [ "$yesorno" == "Y" ] || [ "$yesorno" == "y" ] || [ "$yesorno" == "" ];then
				echo "nameserver 208.67.222.222\nnameserver 8.8.8.8" | sudo tee /etc/resolvconf/resolv.conf.d/tail 1>/dev/null
				sudo systemctl restart NetworkManager
			else
				echo "Ok, You Need To Fix it." 
				exit 1
			fi
		else
			echo -e "\033[92m[+]Your DNS Is OK!"
			exit 0
		fi
##End Of DNS Checking.
	fi
##End of internet checking
fi
##End Of Localnet checking
