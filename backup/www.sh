# Copyright © 2021 Shell.in.net All rights reserved.
# Licensed under the GNU Lesser General Public License v3.0

backup_dir="/var/backup/www"

mkdir -p $backup_dir
/usr/bin/rdiff-backup -b /var/www $backup_dir
/usr/bin/rdiff-backup --force --remove-older-than 7W $backup_dir
