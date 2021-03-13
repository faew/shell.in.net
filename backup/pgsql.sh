# Copyright © 2021 Shell.in.net All rights reserved.
# Licensed under the GNU Lesser General Public License v3.0

backup_dir="/var/backup/pgsql"
cdate=`date +%F`
tdaydir="$backup_dir/$cdate"

mkdir -p $tdaydir
for i in `su -l postgres -c  'psql -l -t' | grep -v template | awk '{ print $1 }' | grep -v '|' | awk 'NF'`
do
    su -l postgres -c "pg_dump -O $i" > $tdaydir/$i.sql
done
cd $backup_dir
tar --remove-files -cPjf "$backup_dir/pgsql_$cdate.tar.bz2" "$cdate"
rm -f $backup_dir/pgsql_`date -d "14 days ago" "+%F"`.tar.bz2
