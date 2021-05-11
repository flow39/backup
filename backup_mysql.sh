#!/bin/bash

sqlUser=""
sqlPass=""
sqlHost="localhost"

#date du jour
date=`date +%y-%m-%d_%H:%M`

#répertoire de sauvegarde
mountPoint="/srv/backup/databases/"

#répertoire des logs
cheminLog="/root/logs"

#durée de rétention
retention=6

#tables
exclusions='(information_schema|performance_schema)'
databases="$(mysql -u $sqlUser -p$sqlPass -Bse 'show databases' | grep -v -E $exclusions)"

#configuration de l'envoi de mail
mailExpe="backupSql@asgard.gipftlv.pro"
mailDest="florian.froidurot@ac-besancon.fr"

echo BACKUP $databases
echo début du backup @ $date

#boucle sur chaque base
for SQL in $databases
do
	echo backup de la base $SQL
	mysqldump -u $sqlUser -p$sqlPass --quick --add-locks --lock-tables --extended-insert $SQL --skip-lock-tables | gzip > ${mountPoint}$SQL"_"$date.sql.gz
done

echo backup terminé @ $date

echo "Suppression des backups de plus de 6 jours : "
find ${mountPoint} -name "*.gz" -mtime +$retention -print -exec rm {} \;

#rapport
echo Rapport envoyé à $date
echo 'Subject:' "BACKUP SQL" | cat - "$cheminLog/backup-asgard-mysql.log" | sendmail -r $mailExpe $mailDest

