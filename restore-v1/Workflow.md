## Workflow Restore
### Giả lập sự cố
docker-compose down
rm -rf /home/owncloud

### Restore
#### Restore data file
cd /home/backup/owncloud
tar -xvf ./owncloud_app_20210903 -C /home/restore/owncloud
cd /home/restore/owncloud/home
cp -r ./owncloud/ /home/

#### Khởi động dịch vụ
cd /home/owncloud/play-owncloud
docker-compose up -d

#### Restore Databae
cd /home/owncloud/play-owncloud
docker-compose exec owncloud occ maintenance:mode --on

cat /home/owncloud/owncloud_db_20210903.sql | docker-compose exec -T mariadb \
    /usr/bin/mysqldump -u root --password=owncloud owncloud 

docker-compose exec owncloud occ maintenance:data-fingerprint
docker-compose exec owncloud occ maintenance:mode --off

### ref
https://doc.owncloud.com/server/admin_manual/maintenance/restore.html