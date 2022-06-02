#!/bin/bash

sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable --now httpd
echo "<h1>Hello World !</h1>" > /var/www/html/index.html

