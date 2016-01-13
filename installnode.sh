rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
yum -y install mesos device-mapper-event-libs docker

# point this node at the mesos master
sed -i -e 's/localhost/192.168.33.10/g' /etc/mesos/zk
echo 'docker,mesos' | sudo tee /etc/mesos-slave/containerizers

service mesos-slave start
chkconfig mesos-slave on
chkconfig mesos-master off

chkconfig docker on
service docker start
docker load --input=/vagrant/outyet.tar.gz
