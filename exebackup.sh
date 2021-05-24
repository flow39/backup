#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
mountPoint="/srv/backup"
mountCommand=""
backupCommand="/root/scripts/./backup.sh &> /root/logs/backup-asgard.log"
backupSqlCommand="/root/scripts/./backup_mysql.sh $> /root/logs/backup-asgard-mysql.log"

eval $mountCommand && eval $backupCommand && eval $backupSqlCommand && eval umount $mountPoint
