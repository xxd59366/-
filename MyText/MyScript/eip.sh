#!/bin/bash
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF
TYPE=Ethernet
BOOTPROTO=none
IPV6INIT=no
NAME=eth0
DEVICE=eth0
ONBOOT=yes
IPADDR=$1
PREFIX=24
EOF
