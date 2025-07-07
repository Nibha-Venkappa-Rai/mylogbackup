#!/bin/bash

#Storing the log folder content in a variable
LOG_VAR="/var/log"

#Backup log folder variable which will be compresses to upload to s3 bucket
BKP_LOG="/bkp"

S3_BUCKET=myappec2

#THRESHOLD_MB=1

#Creating the backup directory
mkdir -p $BKP_LOG

#Copying all the files & sub directories
cp -r $LOG_VAR/* $BKP_LOG

#Creating unique name with timestamp and storing in temp location
UNIQUE_NAME="/tmp/bkp_logs_$(date +%Y%m%d%H%M%S)"
ARCHIVE="$UNIQUE_NAME.tar.gz"

#Compressing backup folder
tar -czf "$ARCHIVE" "$BKP_LOG"

size=$(du -m $ARCHIVE | cut -f1)
if [ $size -gt $THRESHOLD_MB ]
then
       sudo python3 send_email.py
fi

#Pushing to s3 bucket
aws s3 cp $ARCHIVE s3://$S3_BUCKET/


#Also, to installe cronjob utility

sudo yum install cronie -y
sudo systemctl enable crond
sudo systemctl start crond

#cron job creation in console (command to create cron job: crontab -e)
# * * * * * sudo ./log_bkp.sh