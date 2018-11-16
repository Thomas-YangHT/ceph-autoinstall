source $HOME/ceph/CONFIG

docker run \
-d --net=host \
--name=osd \
--privileged=true \
--pid=host \
-v /etc/ceph:/etc/ceph \
-v /var/lib/ceph/:/var/lib/ceph/ \
-v /dev/:/dev/ \
-e OSD_FORCE_ZAP=1 \
-e OSD_TYPE=disk \
-e OSD_DEVICE=${OSD_DEVICE} \
${REGISTRY}ceph/daemon:${RELEASE} \
osd
