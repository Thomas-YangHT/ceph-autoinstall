source $HOME/ceph/CONFIG

docker run \
-d --net=host \
--name=mds \
-v /etc/ceph:/etc/ceph \
-v /var/lib/ceph/:/var/lib/ceph \
-e CEPHFS_CREATE=1 \
${REGISTRY}ceph/daemon:${RELEASE} \
mds
