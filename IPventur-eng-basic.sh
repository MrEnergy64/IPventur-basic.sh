#! /bin/bash
# IPventur-basic.sh
# need root rights, fping and nmap
# updated: 11.06.2020 MrEnergy64 origin: Linux-User
# Version: 0.7
#
# Start without parameter - exit
clear
if [ -z $1 ]; then
	echo ""
	echo "******************************"
	echo "* IPventur-English Basic 0.7 *"
	echo "******************************"
	echo ""
	echo "NETWORK/CIDR (e.g. 192.168.0.0/24) is needed!"
	echo "(Example: sudo ./IPventur-eng-06.sh 10.0.0.0/23 or 192.168.1.1/32 [Enter])"
	exit
fi
clear
echo "-------------------------------------------------------"
# check if fping and nmap installed
echo "-------------------------------------------------------"
	echo ""
	echo "******************************"
	echo "* IPventur-English Basic 0.7 *"
	echo "******************************"
	echo ""
echo
command -v fping >/dev/null 2>&1 || { echo >&2 "I require fping but it's not installed.  Please install."; exit 1; }
echo Program fping is installed!
echo
command -v nmap >/dev/null 2>&1 || { echo >&2 "I require nmap but it's not installed.  Please install."; exit 1; }
echo Program nmap is installed!
echo
echo
echo "Overview active network systems:"
echo "(to get MAC addresses, start the search network as root/sudo)"
echo "--------------------------------------------------------------"
echo
# aktual date and time will be added to the output file
date2=$(date +%d.%m.%Y-%H:%M:%S)
date3=$(date +%d%m%Y)
echo Start: $date2
echo Command: nmap -A -T5 $1
echo
net2=$(echo $1 | cut -d "/" -f 1)
netO=$net2
# Begin creation output file
echo "-------------------------------------------------------" > lanlist-$netO-$date3.txt
echo "Network items $datum / nmap -A -T5 $1" >> lanlist-$netO-$date3.txt
echo "-------------------------------------------------------"
# Scan network and log to the output file, fping checks online IP's only
for k in $(fping -aq -g $1); do
	echo "scanning...: $k"
	echo "Online: $k" >> lanlist-$netO-$date3.txt
# -R do DNS resolution resolve, -sP check IP and give MAC address with Vendor
	nmap -R -sP $k | awk '/Nmap scan report for/{printf $5" "$6;}/MAC Address:/{print " => "$3" "$4" "$5" "$6;}' | sort >> lanlist-$netO-$date3.txt
# -A Enable OS detection, version detection, script scanning, and tracerout, -T<0-5>: Set timing template (higher is faster) 
	nmap -A -T5 $k | grep -B1 open >> lanlist-$netO-$date3.txt
	echo "---------------------------------------------------" >> lanlist-$netO-$date3.txt
echo >> lanlist-$netO-$date3.txt
done
echo "-------------------------------------------------------"
echo "                     E N D" >> lanlist-$netO-$date3.txt
echo
datum=$(date +%d.%m.%Y-%H:%M:%S)
echo $date2 >> lanlist-$netO-$date3.txt
echo "-------------------------------------------------------" >> lanlist-$netO-$date3.txt
echo End: $date2
echo 
# Display output file
less lanlist-$netO-$date3.txt
