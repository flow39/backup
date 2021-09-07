#!/bin/bash

. config.sh

echo BACKUP $databases
echo début du backup @ $date

#boucle sur chaque base
for SQL in $databases
do
	echo backup de la base $SQL
	mysqldump -u $sqlUser -p$sqlPass --quick --add-locks --lock-tables --extended-insert $SQL --skip-lock-tables | gzip > ${mountPointMysql}$SQL"_"$date.sql.gz
done

echo backup terminé @ $date

#on échappe pas le ; à la fin de la commande car ce script est appelé dans une variable par le script exeBackup
echo "Suppression des backups de plus de 6 jours : "
find ${mountPointMysql} -name "*.gz" -mtime +$retention -print -exec rm {} ;

#rapport
echo Rapport envoyé à $date
echo 'Subject:' "BACKUP SQL $serv" | cat - "$cheminLog/backup-$serv-mysql.log" | sendmail -r $mailEnvoi $mailDestinataire

