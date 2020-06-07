#! /bin/sh
# IPventur.sh
# need root rights, fping und nmap
# updated: 23.05.2020 nwoeske origin: Linux-User
# Version: 0.5
#
# Bei Aufruf ohne Parameter abbrechen
clear
if [ -z $1 ]; then
	echo "NETZADRESSE/CIDR muss beim Aufruf angegeben werden!"
	exit
fi
clear
echo "-------------------------------------------------------"
# Check for fping and nmap
echo "-------------------------------------------------------"
echo
command -v fping >/dev/null 2>&1 || { echo >&2 "fping ist nicht installiert!  Bitte installieren."; exit 1; }
echo "Programm fping ist vorhanden!"
echo
command -v nmap >/dev/null 2>&1 || { echo >&2 "nmap ist nicht installiert!  Bitte installieren."; exit 1; }
echo "Programm nmap ist vorhanden!"
echo 
echo
echo "Übersicht aktiver Netzwerkteilnehmer:"
echo "(für MAC Adressen: als root/sudo im selben Netzwerk starten)"
echo "------------------------------------------------------------"
echo
echo
datum=$(date +%d.%m.%Y-%H:%M:%S)
echo $datum  Netz/IP = $1
netz2=$(echo $1 | cut -d "/" -f 1)
netz=$netz2
echo
# Beginn Ergebnisdatei
echo "Netzwerkbestand $datum / $1" > lanliste-$netz.txt
echo "-------------------------------------------------------" >> lanliste-$netz.txt
echo "-------------------------------------------------------"

# Scannen des Netztes und Ablage in Ergebnisdatei
for k in $(fping -aq -g $1); do
	echo "wird untersucht: $k"
	echo "Aktiv: $k" >> lanliste-$netz.txt
	nmap -n -sP $k | awk '/Nmap scan report for/{printf $5;}/MAC Address:/{print " => "$3;}' | sort >> lanliste-$netz.txt
	nmap -A -T5 $k | grep -B1 open >> lanliste-$netz.txt
	echo "---------------------------------------------------" >> lanliste-$netz.txt
done
echo "-------------------------------------------------------"
echo "              E N D E" >> lanliste-$netz.txt
datum=$(date +%d.%m.%Y-%H:%M:%S)
echo $datum >> lanliste-$netz.txt
echo "-------------------------------------------------------" >> lanliste-$netz.txt
echo Ende: $datum
echo
# Anzeige Ergebnisdatei
less lanliste-$netz.txt
