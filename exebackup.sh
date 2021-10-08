#!/bin/bash

. config.sh

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
backupCommand="/root/backup/./backup.sh &> /root/logs/backup-$serv.log"
backupSqlCommand="/root/backup/./backup_mysql.sh $> /root/logs/backup-$serv-mysql.log"

eval $mountCommand && eval $backupCommand && eval $backupSqlCommand && eval umount $mountPoint
