#!/bin/bash
for i in `virsh list | awk '{print $2}' | sed -n '/名称/!p' | grep -v '^$' | sed -n '/Win10/!p'`;do virsh shutdown $i || virsh destroy $i;done
