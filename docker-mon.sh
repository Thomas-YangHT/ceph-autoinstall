source $HOME/ceph/CONFIG
IP=`ip a show dev eth0|grep inet|grep brd|grep -Po 'inet \K\d+.\d+.\d+.\d+'`

docker run \
-d --net=host  \
--name=mon \
-v /etc/ceph:/etc/ceph \
-v /var/lib/ceph/:/var/lib/ceph \
-e MON_IP=${IP} \
-e CEPH_PUBLIC_NETWORK=${PUBLIC_NET} \
${REGISTRY}ceph/daemon:${RELEASE} \
mon
