#!/bin/bash
/usr/sbin/iptables -N PORT-SEQUENCETWO
/usr/sbin/iptables -N PORT-SEQUENCEOK

/usr/sbin/iptables -A INPUT -i lo -j ACCEPT
/usr/sbin/iptables -A INPUT -p icmp -j ACCEPT
/usr/sbin/iptables -A INPUT -m state --state INVALID -j DROP
/usr/sbin/iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
/usr/sbin/iptables -A INPUT -i ens192 -p tcp -m state --state NEW  --dport 22 -s 192.168.50.30 -j DROP
/usr/sbin/iptables -A INPUT -i ens192 -p tcp -m state --state NEW  --dport 22 -j ACCEPT
/usr/sbin/iptables -P INPUT DROP
/usr/sbin/iptables -t nat -A POSTROUTING -o ens192 -j MASQUERADE
# Port Knocking. The correct port sequence is  8881 -> 7777 -> 9991
/usr/sbin/iptables -A INPUT -i ens224 -m state --state NEW -m tcp -p tcp --dport 22 -m recent --rcheck --seconds 30 --name SSH2 -j ACCEPT
/usr/sbin/iptables -A INPUT -i ens224 -m state --state NEW -m tcp -p tcp -m recent --name SSH2 --remove -j DROP
/usr/sbin/iptables -A INPUT -i ens224 -m state --state NEW -m tcp -p tcp --dport 9991 -m recent --rcheck --name SSH1 -j PORT-SEQUENCEOK
/usr/sbin/iptables -A INPUT -i ens224 -m state --state NEW -m tcp -p tcp -m recent --name SSH1 --remove -j DROP
/usr/sbin/iptables -A INPUT -i ens224 -m state --state NEW -m tcp -p tcp --dport 7777 -m recent --rcheck --name SSH0 -j PORT-SEQUENCETWO
/usr/sbin/iptables -A INPUT -i ens224 -m state --state NEW -m tcp -p tcp -m recent --name SSH0 --remove -j DROP
/usr/sbin/iptables -A INPUT -i ens224 -m state --state NEW -m tcp -p tcp --dport 8881 -m recent --name SSH0 --set -j DROP
/usr/sbin/iptables -A PORT-SEQUENCETWO -m recent --name SSH1 --set -j DROP
/usr/sbin/iptables -A PORT-SEQUENCEOK -m recent --name SSH2 --set -j DROP

