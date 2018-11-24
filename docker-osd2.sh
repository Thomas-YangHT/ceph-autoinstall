source $HOME/ceph/CONFIG
OSD_DEVIVE=/dev/vdc
sudo mount $OSD_DEVICE $HOME/ceph/osd

docker run \
-d --net=host \
--name=osd2 \
--privileged=true \
--pid=host \
-v /etc/ceph:/etc/ceph \
-v /var/lib/ceph/:/var/lib/ceph/ \
-v $HOME/ceph/osd:/var/lib/ceph/osd \
-v /dev/:/dev/ \
-e OSD_TYPE=directory \
${REGISTRY}ceph/daemon:${RELEASE} \
osd

#-e OSD_FORCE_ZAP=1 \
#-e OSD_DEVICE=${OSD_DEVICE} \
