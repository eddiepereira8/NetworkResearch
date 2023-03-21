#!/bin/bash
#Eddie/S10/cfc2407/James

#    This script is to automate the processes to connect to a remote server to via ssh protocol anonymously
#    and performing scans such as "Nmap", "Masscan" and "Whois" and saving it on to local host.


#1) We will need to update, download and install the relevant tool in the "inst" functions such as: a) Update Operating System 
#    b) download and installtion of "nipe"  c) Install sshpass

#2) "anon" function is the run "nipe" to be anonymous

#3) "scan" function is to automate access to the remote server via ssh using sshpass and execute nmap scans,S masscan and whois queries
#    and save in on the file in the local host.

function inst()
{
#Updgrade the Kali Linux operating system
sudo apt-get dist-upgrade
#Download nipe files and storing in in the nipe folder
git clone https://github.com/htrgouvea/nipe && cd nipe
#Install Libs and dependecies    
sudo cpan install Try::Tiny Config::Simple JSON
#To run nipe need to in the folder where the  Lids are located
cd "/home/kali/nipe"
sudo perl nipe.pl install
#Install sshpass
sudo apt-get install sshpass
    
    
}





function anon()
{ 
#nipe only runs when your located in the same directory as the nipe.pl with is located in the nipe folder
cd "/home/kali/nipe"
#Restart the nipe circuit
sudo perl nipe.pl restart
echo 'Nipe status:'
#See the nipe status
sudo perl nipe.pl status


echo 'This is the current country code:' 
curl ifconfig.io/country_code

}




function scan()
{
echo "Input remote server IP address:"
read ip
echo "Input remote server username:"
read user
echo "Password for remote server:"
read passwd
#Changing to directory folder to save the scans 
cd /home/kali
#To access the remove server and execute 'whois' and saving in 'whois.scan' file in the local host
sshpass -p $passwd ssh -o StrictHostKeyChecking=No $user@$ip "whois 8.8.8.8" > whois.scan
#To access the remove server and execute 'nmap'and saving in 'nmap_Pn.scan' file in the local host
sshpass -p $passwd ssh -o StrictHostKeyChecking=No $user@$ip "nmap 8.8.8.8 -Pn" > nmap_Pn.scan
#To access the remove server and execute 'masscan' amd saving in 'masscan_p80_p443.scan' in the local host
sshpass -p $passwd ssh -o StrictHostKeyChecking=No $user@$ip "sudo -S masscan 8.8.8.8 -p80 -p443" > masscan_p80_p443.scan
}


#Recall the function variable to execute the block of code
inst
anon
scan


