#!/bin/bash
for i in mysql{50..58}
do
  cat /etc/libvirt/qemu/$i.xml > /tmp/mycp.xml
  sed -i "/uuid/s/<uuid>.*<\/uuid>//" /tmp/mycp.xml
  sed -i "/<memory/s/1048576/524288/" /tmp/mycp.xml
  virsh undefine $i
  virsh define /tmp/mycp.xml
done
