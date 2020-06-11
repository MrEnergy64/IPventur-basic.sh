#! /bin/bash
# IPventur-basic.sh
# benötigt root rechte, sowie fping und nmap
# updated: 11.06.2020 MrEnergy64 origin: Linux-User
# Version: 0.7
#
# Bei Aufruf ohne Parameter abbrechen
clear
if [ -z $1 ]; then
	echo ""
	echo "******************************"
	echo "* IPventur-Deutsch Basic 0.7 *"
	echo "******************************"
	echo ""
	echo "NETZADRESSE/Subnetmask muss beim Aufruf angegeben werden!"
	echo "(Beispiel: sudo ./IPventur-ger-06.sh 10.0.0.0/23 oder 192.168.1.1/32 [Enter])"
	exit
fi
clear
echo "-------------------------------------------------------"
# Check for fping and nmap
echo "-------------------------------------------------------"
	echo ""
	echo "******************************"
	echo "* IPventur-Deutsch Basic 0.7 *"
	echo "******************************"
	echo ""
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
# aktuelles Startdatum und Uhrzeit wird der Ausgangsdatei hinzugefügt
datum=$(date +%d.%m.%Y-%H:%M:%S)
datum2=$(date +%d%m%Y)
echo Start: $datum
echo Kommando: nmap -A -T5 $1
echo
netz2=$(echo $1 | cut -d "/" -f 1)
netz=$netz2
# Beginn Ergebnisdatei
echo "-------------------------------------------------------" > lanliste-$netz-$datum2.txt
echo "Netzwerkbestand $datum / nmap -A -T5 $1" >> lanliste-$netz-$datum2.txt
echo "-------------------------------------------------------"
# Scannen des Netztes und Ablage in Ergebnisdatei, fping stellt fest welche IP Online ist
for k in $(fping -aq -g $1); do
	echo "wird untersucht: $k"
	echo "Aktiv: $k" >> lanliste-$netz-$datum2.txt
# -n startet kein IP DNS Namen check (nur IP Adresse), -sP zeigt IP Adresse mit MAC Adresse und Hersteller ID
	nmap -n -sP $k | awk '/Nmap scan report for/{printf $5;}/MAC Address:/{print " => "$3" "$4" "$5;}' | sort >> lanliste-$netz-$datum2.txt
# -A zeigt mehr Informationen wie OS Version, Traceroute, welche Scripts laufen etc.
	nmap -A -T5 $k | grep -B1 open >> lanliste-$netz-$datum2.txt
	echo "---------------------------------------------------" >> lanliste-$netz-$datum2.txt
echo >> lanliste-$netz-$datum2.txt
done
echo "-------------------------------------------------------"
echo "                      E N D E" >> lanliste-$netz-$datum2.txt
echo 
datum=$(date +%d.%m.%Y-%H:%M:%S)
echo $datum >> lanliste-$netz-$datum2.txt
echo "-------------------------------------------------------" >> lanliste-$netz-$datum2.txt
echo Ende: $datum
echo
# Anzeige Ergebnisdatei
less lanliste-$netz-$datum2.txt
