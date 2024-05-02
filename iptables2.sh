#!/bin/bash
/usr/sbin/iptables -A INPUT -i lo -j ACCEPT
/usr/sbin/iptables -A INPUT -p icmp -j ACCEPT
/usr/sbin/iptables -A INPUT -m state --state INVALID -j DROP
/usr/sbin/iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
/usr/sbin/iptables -A INPUT -p tcp -m state --state NEW  --dport 22 -j ACCEPT
/usr/sbin/iptables -P INPUT DROP
/usr/sbin/iptables -t nat -A POSTROUTING -o ens192 -j MASQUERADE
/usr/sbin/iptables -t nat -A PREROUTING -p tcp --dport 8080 -j DNAT --to 192.168.50.30:80
/usr/sbin/iptables -t nat -A PREROUTING -p tcp --dport 2022 -j DNAT --to 192.168.50.30:22