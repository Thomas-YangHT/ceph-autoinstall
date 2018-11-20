source ./CONFIG

docker run --name haproxy \
-v $HOME/ceph/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
-p 18433:8433 \
-p 19090:9090 \
-p 13000:3000 \
-p 16789:6789 \
-p 17480:7480 \
-p 9091:9091 \
--restart=always \
-d haproxy
