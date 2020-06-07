# IPventur.sh
IP collector script for beginners
This little helping tool, collects IP addresses and open ports with nmap and fping (need to be installed).
to start the tool and invest MAC addresses as well:

sudo ./IPventur-eng.sh 192.168.x.x/24  (German version IPventur-ger.sh)

The script will check first if nmap and fping available, and when yes, it will starts with the investigation:

-------------------------------------------------------                       
-------------------------------------------------------                       
                                                                              
Program fping is installed!                                                   
                                                                              
Program nmap is installed!                                                    
                                                                              
                                                                              
Overview activ network systems:                                               
(to get MAC addresses be in the same search network root)                     
--------------------------------------------------------------                
                                                                              
Start: 07.06.2020-12:56:01 Net/IP = 192.168.222.0/24                          
                                                                              
-------------------------------------------------------                       
scanning...: 192.168.222.1                                                    
scanning...: 192.168.222.64                                                   
scanning...: 192.168.222.72                                                   
-------------------------------------------------------                       
                                                                              
End: 07.06.2020-12:56:01    

At the end you will have a text file with your investigations:

(here example German output with MAC addresses):

Netzwerkbestand 07.06.2020-12:55:16 / 10.0.222.0/24
-------------------------------------------------------
Aktiv: 10.0.222.1
10.0.222.1 => CC:EF:48:95:5D:D8
PORT   STATE SERVICE
22/tcp open  ssh
53/tcp open  domain
---------------------------------------------------
Aktiv: 10.0.222.3
10.0.222.3 => 24:5E:BE:0F:C3:B1
PORT      STATE SERVICE
21/tcp    open  ftp
22/tcp    open  ssh
80/tcp    open  http
111/tcp   open  rpcbind
139/tcp   open  netbios-ssn
389/tcp   open  ldap
443/tcp   open  https
445/tcp   open  microsoft-ds
548/tcp   open  afp
631/tcp   open  ipp
636/tcp   open  ldapssl
873/tcp   open  rsync
2049/tcp  open  nfs
6881/tcp  open  bittorrent-tracker
8080/tcp  open  http-proxy
8200/tcp  open  trivnet1
30000/tcp open  ndmps
49152/tcp open  unknown
49153/tcp open  unknown
---------------------------------------------------
Aktiv: 10.0.222.4
10.0.222.4 => 9C:5C:8E:D3:8A:A0
<omitted>

Feel free to change the nmap parameters with your own wishes.

Happy collecting!

Mr.Energy

