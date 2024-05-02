#!/bin/bash
nmap -Pn --host-timeout 201 --max-retries 0  -p 8881 192.168.50.10 #knocking port 8881
nmap -Pn --host-timeout 201 --max-retries 0  -p 7777 192.168.50.10 #knocking port 7777
nmap -Pn --host-timeout 201 --max-retries 0  -p 9991 192.168.50.10 #knocking port 9991