# Copyright © 2021 Shell.in.net All rights reserved.
# Licensed under the GNU Lesser General Public License v3.0

sqluser="admin"
sqlpass=`cat /etc/shell.in.net/mongo-pwd`
backup_dir="/var/backup/mongo"
cdate=`date +%F`
tdaydir="$backup_dir/$cdate"

mkdir -p $tdaydir
mongodump --username $sqluser --password $sqlpass mongodb://127.0.0.1:27017 --out $tdaydir

cd $backup_dir
tar --remove-files -cPjf "$backup_dir/mongo_$cdate.tar.bz2" "$cdate"
rm -f $backup_dir/mongo_`date -d "14 days ago" "+%F"`.tar.bz2
