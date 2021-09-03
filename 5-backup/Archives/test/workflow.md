### Backup Workflow
1. Run script install-dependencies.sh
2. Config rclone manual
   - rclone config
3. Edit script backup for app1.
   - change name app
   - edit password for email postfix.
4. Copy script backup-app1.sh to /usr/bin/  
5. Run script backup.sh
6. If need backup app2, repeat step 3-5.
7. Done!

vi /etc/cron.d/app1.cron
systemctl restart crond
vi /usr/bin/backup-app1.sh
vi 
./backup-app1.sh
systemctl restart crond

tail -f /var/log/maillog
 /etc/postfix/sasl_passwd.db











[root@docker-production1 network-scripts]# cat ifcfg-ens192
TYPE="Ethernet"
PROXY_METHOD="none"
BROWSER_ONLY="no"
BOOTPROTO="none"
DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
IPV6INIT="yes"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="ens192"
UUID="a8323108-8581-40ab-a539-bbd6ab58469c"
DEVICE="ens192"
ONBOOT="yes"
IPADDR="192.168.1.243"
PREFIX="24"
GATEWAY="192.168.1.1"
DNS1="8.8.8.8"
IPV6_PRIVACY="no"
[root@docker-production1 network-scripts]#
