# IPventur.sh
IP collector script for beginners.
This little helping tool, collects IP addresses and open ports with nmap and fping (need to be installed).
To start the tool and invest MAC addresses as well:

chmod +x IPventur-eng-basic.sh (or chmod +x IPventur-ger-basic.sh)

sudo ./IPventur-eng-basic.sh 192.168.1.0/24 <=network example, always use netmask (German version IPventur-ger-basic.sh)

The script will check first, if nmap and fping available, and when yes, it will starts with the investigation.

Feel free to change the nmap parameters with your own wishes!

Happy collecting!

Mr.Energy

P.S. if you would like to get more details or use scripts, check out my IPventur-Pro version!
