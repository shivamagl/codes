#!/bin/bash
sudo wget -O /home/ubuntu/userdata.sh https://s3.amazonaws.com/scalemonks/userdata/userdata-testing.sh
sudo bash /home/ubuntu/userdata.sh
sudo service nginx stop
sudo aws s3 cp s3://scalemonks/project-code/index.html /usr/share/nginx/html/index.html --region us-east-1
sudo service nginx start
