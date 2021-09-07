#!/bin/bash

#VARIABLES
serv="machine"
mountCommand=""
mountPoint="/srv/backup"
cheminLog="/root/logs"
dossierCible="/var/www/html"
dossierCible1="/etc/apache2/sites-available"
sendmail="sendmail"
mailEnvoi="backup@machine.local"
mailDestinataire="toto@toto.com"
rsyncCommand="rsync -rlptD"
rsyncOpt="--delete-after"

#eval $mountCommand

echo --- BACKUP $dossierCible ---
echo début de la synchronisation @ $(date +%d-%m-%y_%H:%M)
eval $rsyncCommand $dossierCible $mountPoint $rsyncOpt
echo Synchronisation du dossier cible $dossierCible terminée à $(date +%H:%M)
echo --- BACKUP $dossierCible1 ---
echo début de la synchronisation @ $(date +%d-%m-%y_%H:%M)
eval $rsyncCommand $dossierCible1 $mountPoint $rsyncOpt
echo Synchronisation du dossier cible $dossierCible1 terminée à $(date +%H:%M)

du -h $mountPoint

#eval umount $mountPoint

#RAPPORT
echo Rapport envoyé @ $(date +%d-%m-%y_%H:%M)
echo 'Subject:' "BACKUP $serv" | cat - "$cheminLog/backup-$serv.log" | $sendmail -r $mailEnvoi $mailDestinataire
echo Rapport terminé
