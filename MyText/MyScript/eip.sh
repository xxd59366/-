#!/bin/bash
cat > /etc/sysconfig/network-scripts/ifcfg-$1 << EOF
TYPE=Ethernet
BOOTPROTO=none
IPV6INIT=no
NAME=$1
DEVICE=$1
ONBOOT=yes
IPADDR=$2
PREFIX=24
EOF
