#!/bin/bash

backuppath=/etc/postgres.backups/
backupfile=postgres_backup_docker_id_$(hostname -f)_$(date +"%Y_%m_%d_%I_%M_%p").sql

echo "####"
echo " "

echo "Creating backup: $backuppath$backupfile"
# Backup a specific database
# pg_dump -U $POSTGRES_USER <database name> $backuppath$backupfile
# Backup all databases
pg_dumpall -U $POSTGRES_USER --verbose -f $backuppath$backupfile

echo "Compressing backup: $backuppath$backupfile.gz"
gzip $backuppath$backupfile

# Delete files older than 5 days
days=5
echo "Cleaning files older than $days days: $backuppath*.gz"
find /etc/postgres.backups/ -name "*.gz" -type f -mtime +$days -delete

echo "Finished backup"

echo " "
echo "####"
