# Script backup app owncloud on server to google drive
#!/bin/sh

# declare variable
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
SERVER_NAME=${HOSTNAME}
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/home/backup/owncloud"
# folder need backup owncloud
APP_DIR="/home/owncloud"
APP_NAME="owncloud"
SCRIPT_BACKUP=/usr/bin/backup-owncloud.sh
SECONDS=0

# Make folder backup for owncloud
if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
fi

# Backup database
# Enter service mariadb
cd /home/owncloud/play-owncloud
docker-compose exec mariadb \
     /usr/bin/mysqldump -u root --password=owncloud \
     owncloud > owncloud_db_$(date +%Y%m%d).sql
mv ./owncloud_db_$(date +%Y%m%d).sql "$APP_DIR"

# Backup data file
cd "$BACKUP_DIR"
tar -czf backup_app_$(date +%Y%m%d).tar.gz "$APP_DIR" >/dev/null 2>&1

# Keep the last 3 backups
find "$BACKUP_DIR" -type f -name "*.gz" -mtime +3 -delete

# config cron
if [ ! -f /etc/cron.d/owncloud.cron ]; then
cat > "/etc/cron.d/owncloud.cron" <<EOF
SHELL=/bin/sh
0 0 * * * root $SCRIPT_BACKUP >/dev/null 2>&1
EOF
echo "Restarting crond service"
systemctl restart crond.service
fi

# Backup on Google Drive
echo "Starting Uploading Backup on Google Drive "
rclone copy $BACKUP_DIR "remote:$SERVER_NAME/$TIMESTAMP/$APP_NAME" >> /var/log/rclone.log 2>&1

# Clean up Google Drive
rclone -q --min-age 2w delete "remote:$SERVER_NAME" #Remove all backups older than 2 week
rclone -q --min-age 2w rmdirs "remote:$SERVER_NAME" #Remove all empty folders older than 2 week
rclone cleanup "remote:" >/dev/null 2>&1 #Cleanup Trash
echo "Finished";
echo '';

duration=$SECONDS
echo "Total $size, $(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."