### Workflow Restore
### backup
cd /home/backup/nextcloud
tar -czf backup-$(date +%F\-%H\-%M\-%S).tar.gz /home/nextcloud >/dev/null 2>&1

### Gỉa lập bị sự cố
rm -rf /home/nextcloud/data

### Restore From local disk
mkdir -p /home/restore/nextcloud
cd /home/backup/nextcloud
tar -xvf backup-2021-09-03-07-36-00.tar.gz -C /home/restore/nextcloud
cd /home/restore/nextcloud/home/nextcloud
cp -r ./data /home/nextcloud

### Gỉa lập bị sự cố
rm -rf /home/nextcloud/data

