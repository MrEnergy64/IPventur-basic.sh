#! /bin/sh
# IPventur.sh
# need root rights, fping and nmap
# updated: 08.06.2020 mr.energy origin: Linux-User
# Version: 0.6
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
echo "Overview active network systems:"
echo "(to get MAC addresses, start the search network as root/sudo)"
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

# Scan network and log to the output file, fping checks online IP's only
for k in $(fping -aq -g $1); do
	echo "scanning...: $k"
	echo "Online: $k" >> lanlist-$netO.txt
# -n Never do DNS resolution resolve, -sP check if IP up and give MAC address with Vendor
	nmap -n -sP $k | awk '/Nmap scan report for/{printf $5;}/MAC Address:/{print " => "$3" "$4" "$5;}' | sort >> lanlist-$netO.txt
# -A Enable OS detection, version detection, script scanning, and tracerout, -T<0-5>: Set timing template (higher is faster) 
	nmap -A -T5 $k | grep -B1 open >> lanlist-$netO.txt
	echo "---------------------------------------------------" >> lanlist-$netO.txt
echo >> lanlist-$net0.txt
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
