## Workflow backup and restore

### Prepare folder owncloud, backup, restore
mkdir -p /home/owncloud
mkdir -p /home/backup/owncloud
mkdir -p /home/restore/owncloud

### backup database
#### Enter service mariadb
cd /home/owncloud/play-owncloud
docker-compose exec mariadb \
     /usr/bin/mysqldump -u root --password=owncloud \
     owncloud > owncloud_db_$(date +%Y%m%d).sql

### backup app and db use tar tool
cd /home/backup/owncloud
tar -czf owncloud_app_$(date +%Y%m%d).tar.gz /home/owncloud