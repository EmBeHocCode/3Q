#!/bin/bash
HOSTNAME="localhost"
PORT="3306"
USERNAME="root"
PASSWORD="EHrWXkpA30e6f7CQx2cx"
WEB="WEB"

mysql -h$HOSTNAME -P$PORT -u$USERNAME -p$PASSWORD -e "create database $WEB DEFAULT CHARACTER SET utf8;"
mysql -u$USERNAME -p$PASSWORD $WEB < web.sql
