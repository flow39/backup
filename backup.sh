#!/bin/bash

. config.sh

rsyncCommand="rsync -rlptD"
rsyncOpt="--delete-after"

#eval $mountCommand

echo --- BACKUP $dossierCible ---
echo début de la synchronisation @ $(date +%d-%m-%y_%H:%M)
eval $rsyncCommand $rsyncOpt $dossierCible $mountPoint 
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
