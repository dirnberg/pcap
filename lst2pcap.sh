#!/bin/bash
rm ./out/*
IPLIST=$1
while read IP;
	do
	tcprewrite --infile=muddywater.pcap --outfile=out/$IP.pcap --dstipmap=185.117.75.34:$IP --srcip=185.117.75.34:$IP;
	done < "$IPLIST"  >results.csv
