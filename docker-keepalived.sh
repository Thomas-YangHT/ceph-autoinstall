sudo modprobe ip_vs
source ./CONFIG
docker run --net=host \
--cap-add=NET_ADMIN \
--name keepalived \
-e VIRTUAL_IP="$VIP_IP" \
-e VIRTUAL_ROUTER_ID=52 \
-e STATE=`[ $HOSTNAME = "$NODE1_NAME" ] && echo MASTER || echo BACKUP` \
-e PRIORITY=`[ $HOSTNAME = "$NODE1_NAME" ] && echo 101 || echo 100` \
--restart=always \
-d keepalived 
