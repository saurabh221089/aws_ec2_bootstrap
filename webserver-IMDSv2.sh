#!/bin/bash
yum update -y
yum install httpd -y
chkconfig httpd on
service httpd start
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 600"`
INSTANCE_ID=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id`
aws s3 cp s3://<bucket-name>/index.html /var/www/html
sed -i -e "s/ec2instance_id/$INSTANCE_ID/" /var/www/html/index.html
chown -R apache:apache /var/www/html