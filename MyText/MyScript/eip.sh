#!/bin/bash

######################################
############获取设备验证##############
getDev(){
ifconfig $1 &> /dev/null
if [ $? -ne 0 ];then
	echo "error device" >&2
	exit 2
else
	echo "change $1"
fi
}

############改变配置####################
changeIP(){

path='/etc/sysconfig/network-scripts/ifcfg-'
for i in {BOOTPROTO,IPADDR,PREFIX,GATEWAY,ONBOOT}
do
	read -p "$i: " $i
done

cat > $path$1 << EOF
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=$BOOTPROTO
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
NAME=$1
DEVICE=$1
ONBOOT=$ONBOOT
IPADDR=$IPADDR
PREFIX=$PREFIX
GATEWAY=$GATEWAY
EOF

echo

for i in {BOOTPROTO,IPADDR,PREFIX,GATEWAY,ONBOOT}
do
        temp=
        eval temp=$(echo \$$i)
        if [ ! $temp ];then
                echo $i remove
                sed -i "/$i/d" $path$1
        else
                echo $i=$temp
        fi
done
}

##################执行##################
if [ "$1" != "" ];then
	getDev $1
	changeIP $1
else
	echo "device please" >&2
fi
