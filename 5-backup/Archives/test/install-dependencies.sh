# Script install-dependencies for backup solution
#!/bin/sh

# Install rclone
if [ ! -f /usr/sbin/rclone ]; then
    yum -y install wget unzip
    cd /root/
    wget https://downloads.rclone.org/rclone-current-linux-amd64.zip
    unzip rclone-current-linux-amd64.zip
    cp rclone-v*-linux-amd64/rclone /usr/sbin/
    rm -rf rclone-*
fi



