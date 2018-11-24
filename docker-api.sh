source $HOME/ceph/CONFIG

docker run \
-d --net=host \
--name=restapi \
-v /etc/ceph:/etc/ceph \
-v /var/lib/ceph/:/var/lib/ceph  \
${REGISTRY}ceph/daemon:${RELEASE} \
restapi
