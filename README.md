# IPventur.sh
IP collector script for beginners.
This little helping tool, collects IP addresses and open ports with nmap and fping (need to be installed).
To start the tool and invest MAC addresses as well:

chmod +x IPventur-eng.sh (or chmod +x IPventur-ger.sh) (new 0.6 version: chmod +x IPventur-eng-06.sh or chmod +x IPventur-ger-06.sh)

sudo ./IPventur-eng.sh 192.168.1.0/24 <=network example (German version IPventur-ger.sh)

(new 0.6 version start with "sudo ./IPventur-eng-06.sh 192.168.1.0/24 or sudo ./IPventur-ger-06.sh 192.168.1.0/24"

The script will check first, if nmap and fping available, and when yes, it will starts with the investigation.

Feel free to change the nmap parameters with your own wishes!

Happy collecting!

Mr.Energy

