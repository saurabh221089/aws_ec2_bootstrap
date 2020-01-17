#!/bin/bash
yum update -y
yum install httpd -y
chkconfig httpd on
service httpd start
cd /var/www/html
wget https://fileversion.s3.ap-south-1.amazonaws.com/index.html
chown -R apache:apache /var/www/html