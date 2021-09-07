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
#Identifiants Mysql
sqlUser=""
sqlPass=""
sqlHost="localhost"
#date du jour
date=`date +%y-%m-%d_%H:%M`
#répertoire de sauvegarde
mountPointMysql="/srv/backup/databases/"
#durée de rétention
retention=6
#tables
exclusions='(information_schema|performance_schema)'
databases="$(mysql -u $sqlUser -p$sqlPass -Bse 'show databases' | grep -v -E $exclusions)"


