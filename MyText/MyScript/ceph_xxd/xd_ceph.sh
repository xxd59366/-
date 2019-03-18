#!/bin/bash

  baseDIR=`pwd -P`
  vname=ceph_node
  baseVM=rh7_template

set_vm(){
#####生成三台虚拟机#####
echo "1.生成3台虚拟机"
cd /var/lib/libvirt/images
##生成磁盘,系统盘为快照,数据盘为新盘#####
### OK ###
for i in {1..3}
do
  newVM=${vname}${i}
  qemu-img create -f qcow2 -b .${baseVM}img ${newVM}.img 20G > /dev/null
  qemu-img create -f qcow2 ${newVM}_data02.img 20G > /dev/nul
  qemu-img create -f qcow2 ${newVM}_data02.img 20G > /dev/null
done
##########生成xml文件################
### OK ###
for i in {1..3}
do
  newVM=${vname}${i}
  cp ${baseDIR}/xml/.rhel7.xml  /tmp/${vname}_tmp.xml
  sed -i "/<name>${baseVM}/s/${baseVM}/${newVM}/" /tmp/${vname}_tmp.xml
  for ct in {1..4}
  do
    sed -i "/${baseVM}${ct}\.img/s/${baseVM}${ct}/${newVM}/" /tmp/${vname}_tmp.xml
  done
  virsh define /tmp/${vname}_tmp.xml
done
}


########################################################

set_yum(){

### 生成ceph_yum.repo ###

cat > ceph_yum.repo << EOF
[rhel7]
name=redhat
baseurl=ftp://192.168.4.254/rhel7
enabled=1
gpgcheck=0

[mon]
name=mon
baseurl=ftp://192.168.4.254/ceph/rhceph-2.0-rhel-7-x86_64/MON
gpgcheck=0

[OSD]
name=osd
baseurl=ftp://192.168.4.254/ceph/rhceph-2.0-rhel-7-x86_64/OSD
gpgcheck=0

[tools]
name=tools
baseurl=ftp://192.168.4.254/ceph/rhceph-2.0-rhel-7-x86_64/Tools
gpgcheck=0

[radosgw]
name=RGW
baseurl=ftp://192.168.4.254/rpm
gpgcheck=0
EOF
}

########################################################

set_env(){
echo "开始准备实验环境..."


}

########################################################
###################### 执行部分 ########################
########################################################

set_vm
