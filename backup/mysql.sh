# Copyright © 2021 Shell.in.net All rights reserved.
# Licensed under the GNU Lesser General Public License v3.0

sqluser="root"
sqlpass=`cat /etc/shell.in.net/mysql-pwd`
backup_dir="/var/backup/mysql"
cdate=`date +%F`
tdaydir="$backup_dir/$cdate"

mkdir -p $tdaydir
for i in `find /var/lib/mysql -type d | grep -v innodb_temp | gawk -F "/" '{print $5}'`
do
    mysqldump -R -u$sqluser -p$sqlpass $i > "$tdaydir/$i.sql"
    mysql -u$sqluser -p$sqlpass mysql -s -e "select authentication_string from user where host='%' and user='$i';" > "$tdaydir/$i.key"
done
cd $backup_dir
tar --remove-files -cPjf "$backup_dir/mysql_$cdate.tar.bz2" "$cdate"
rm -f $backup_dir/mysql_`date -d "14 days ago" "+%F"`.tar.bz2
