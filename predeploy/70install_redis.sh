#!/bin/bash
# from here: http://www.codingsteps.com/install-redis-2-6-on-amazon-ec2-linux-ami-or-centos/
# and here: https://raw.github.com/gist/257849/9f1e627e0b7dbe68882fa2b7bdb1b2b263522004/redis-server
###############################################
echo "*****************************************"
echo " 1. Download, Untar and Make Stable Redis"
echo "*****************************************"
cd /usr/local/src
sudo wget http://download.redis.io/redis-stable.tar.gz
sudo tar xzf redis-stable.tar.gz
sudo rm redis-stable.tar.gz -f
cd redis-stable
sudo make
echo "*****************************************"
echo " 2. Create Directories and Copy Redis Files"
echo "*****************************************"
sudo mkdir /etc/redis /var/lib/redis
sudo cp src/redis-server src/redis-cli /usr/local/bin
echo "*****************************************"
echo " 3. Configure Redis.Conf"
echo "*****************************************"
echo " Edit redis.conf as follows:"
echo " 1: ... daemonize yes"
echo " 2: ... bind 127.0.0.1"
echo " 3: ... dir /var/lib/redis"
echo " 4: ... loglevel notice"
echo " 5: ... logfile /var/log/redis.log"
echo "*****************************************"
sudo sed -e "s/^daemonize no$/daemonize yes/" -e "s/^# bind 127.0.0.1$/bind 127.0.0.1/" -e "s/^dir \.\//dir \/var\/lib\/redis\//" -e "s/^loglevel verbose$/loglevel notice/" -e "s/^logfile stdout$/logfile \/var\/log\/redis.log/" redis.conf | sudo tee /etc/redis/redis.conf
echo "*****************************************"
echo " 4. Download init Script"
echo "*****************************************"
sudo wget https://raw.githubusercontent.com/jakemmarsh/ebs-setup/master/redis-server
echo "*****************************************"
echo " 5. Move and Configure Redis-Server"
echo "*****************************************"
sudo mv redis-server /etc/init.d
sudo chmod 755 /etc/init.d/redis-server
