echo "*****************************************"
echo " 1. Auto-Enable Redis-Server"
echo "*****************************************"
sudo chkconfig --add redis-server
sudo chkconfig --level 345 redis-server on
echo "*****************************************"
echo " 2. Start Redis Server"
echo "*****************************************"
sudo service redis-server start
