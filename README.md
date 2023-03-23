# How to generate a pcap with bad reputation IPs

tested with Ubuntu 22.04

1. Create a file with bad repuations IPs

touch ip.txt
nano ip.txt

2. Create the bash scriot lst2pcap.sh

#!/bin/bash
rm ./out/*
IPLIST=$1
while read IP;
	do
	tcprewrite --infile=muddywater.pcap --outfile=out/$IP.pcap --dstipmap=185.117.75.34:$IP --srcip=185.117.75.34:$IP;
	done < "$IPLIST"  >results.csv
 
3. Start the bashscript with sudo rights

nohup sudo ./lst2pcap.sh ip.lst

4. Start on another machine with root rigths tcpdump

cd /data/capture (if folder not exists mkdir /data/capture)

nohup tcpdump -i port1 -s 0 -C 500 -w capture.pcap -vvv

(also connect the network cable between both computer)

5. As last step start replay all pcaps inside the out folder

cd out
for f in *.pcap; do tcpreplay -i enx00809b002a3f --mbps=0.001 $f; done

6. Copy the capture file via ssh.
capture.pcap

scp admin@192.168.1.254:/data/capture/capture.pcap capture.pcap
  
