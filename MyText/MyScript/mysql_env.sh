#!/bin/bash
for i in {50..58};do echo $i | clone-vm7;sleep 1;done

for i in {50..58}; do cat /etc/libvirt/qemu/rh7_node$i.xml > /tmp/mycp.xml; sed -i "/<name>rh7_node$i/s/rh7_node$i/mysql$i/" /tmp/mycp.xml; sed -i "/uuid/s/<uuid>.*<\/uuid>//" /tmp/mycp.xml; virsh define /tmp/mycp.xml; virsh undefine rh7_node$i; done
