#!/bin/bash
/usr/sbin/iptables -A INPUT -i lo -j ACCEPT
/usr/sbin/iptables -A INPUT -p icmp -j ACCEPT
/usr/sbin/iptables -A INPUT -m state --state INVALID -j DROP
/usr/sbin/iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
/usr/sbin/iptables -A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT
/usr/sbin/iptables -A INPUT -p tcp -m state --state NEW --dport 80 -j ACCEPT
/usr/sbin/iptables -P INPUT DROP
# policy routing, send packetы from port 80 via 192.168.50.20
/usr/sbin/iptables -t mangle -A OUTPUT -p tcp -m tcp --sport 80 -j MARK --set-mark 0x2
/usr/sbin/iptables -t mangle -A OUTPUT -p tcp -m tcp --sport 22 -j MARK --set-mark 0x2
/usr/sbin/ip route add default via 192.168.50.20 dev ens192 table 102
/usr/sbin/ip rule add fwmark 0x2/0x2 lookup 102
