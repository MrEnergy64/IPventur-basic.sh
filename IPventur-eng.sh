#! /bin/sh
# IPventur.sh
# need root rights, fping and nmap
# updated: 23.05.2020 mr.energy origin: Linux-User
#
# Start without parameter - exit
clear
if [ -z $1 ]; then
	echo "NETWORK/CIDR (e.g. 192.168.0.0/24) is needed!"
	exit
fi
clear
echo "-------------------------------------------------------"
# check if fping and nmap installed
echo "-------------------------------------------------------"
echo
command -v fping >/dev/null 2>&1 || { echo >&2 "I require fping but it's not installed.  Please install."; exit 1; }
echo Program fping is installed!
echo
command -v nmap >/dev/null 2>&1 || { echo >&2 "I require nmap but it's not installed.  Please install."; exit 1; }
echo Program nmap is installed!
echo
echo
echo "Overview activ network systems:"
echo "(to get MAC addresses be in the same search network root)"
echo "--------------------------------------------------------------"
echo
date2=$(date +%d.%m.%Y-%H:%M:%S)
echo Start: $date2  Net/IP = $1
echo
net2=$(echo $1 | cut -d "/" -f 1)
netO=$net2
# Begin creation output file
echo "Network items $datum / $1" > lanlist-$netO.txt
echo "-------------------------------------------------------" >> lanlist-$netO.txt
echo "-------------------------------------------------------"

# Scan network and log to the output file
for k in $(fping -aq -g $1); do
	echo "scanning...: $k"
	echo "Online: $k" >> lanlist-$netO.txt
	nmap -n -sP $k | awk '/Nmap scan report for/{printf $5;}/MAC Address:/{print " => "$3;}' | sort >> lanlist-$netO.txt
	nmap $k | grep -B1 open >> lanlist-$netO.txt
	echo "---------------------------------------------------" >> lanlist-$netO.txt
done
echo "-------------------------------------------------------"
echo "              E N D" >> lanlist-$netO.txt
echo
datum=$(date +%d.%m.%Y-%H:%M:%S)
echo $date2 >> lanlist-$netO.txt
echo "-------------------------------------------------------" >> lanlist-$netO.txt
echo End: $date2
echo 
# Display output file
less lanlist-$netO.txt
