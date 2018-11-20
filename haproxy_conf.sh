source ./CONFIG
cat << EOF > haproxy.cfg
global
  log 127.0.0.1 local0
  log 127.0.0.1 local1 notice
  tune.ssl.default-dh-param 2048

defaults
  log global
  mode http
  option dontlognull
  timeout connect 5000ms
  timeout client  600000ms
  timeout server  600000ms

listen stats
    bind :9091
    mode http
    balance
    stats uri /haproxy_stats
    stats auth admin:admin
    stats admin if TRUE

frontend ceph-dashboard-https-8443
   mode tcp
   bind :8433
   default_backend ceph-dashboard-backend

backend ceph-dashboard-backend
    mode tcp
    balance roundrobin
    stick-table type ip size 200k expire 30m
    stick on src
    server $NODE1_NAME $NODE1_IP:8443 check
    server $NODE2_NAME $NODE2_IP:8443 check
    server $NODE3_NAME $NODE3_IP:8443 check

frontend ceph-grafana-http-3000
   mode tcp
   bind :3000
   default_backend ceph-grafana-backend

backend ceph-grafana-backend
    mode tcp
    balance roundrobin
    stick-table type ip size 200k expire 30m
    stick on src
    server $NODE1_NAME $NODE1_IP:3000 check
    server $NODE2_NAME $NODE2_IP:3000 check
    server $NODE3_NAME $NODE3_IP:3000 check

frontend ceph-rgw-http-7480
   mode tcp
   bind :7480
   default_backend ceph-rgw-backend

backend ceph-rgw-backend
    mode tcp
    balance roundrobin
    stick-table type ip size 200k expire 30m
    stick on src
    server $NODE1_NAME $NODE1_IP:7480 check
    server $NODE2_NAME $NODE2_IP:7480 check
    server $NODE3_NAME $NODE3_IP:7480 check

frontend ceph-prometheus-http-9090
   mode tcp
   bind :9090
   default_backend ceph-prometheus-backend

backend ceph-prometheus-backend
    mode tcp
    balance roundrobin
    stick-table type ip size 200k expire 30m
    stick on src
    server $NODE1_NAME $NODE1_IP:9090 check
    server $NODE2_NAME $NODE2_IP:9090 check
    server $NODE3_NAME $NODE3_IP:9090 check

frontend ceph-mon-tcp-6789
   mode tcp
   bind :6789
   default_backend ceph-mon-backend

backend ceph-mon-backend
    mode tcp
    balance roundrobin
    stick-table type ip size 200k expire 30m
    stick on src
    server $NODE1_NAME $NODE1_IP:6789 check
    server $NODE2_NAME $NODE2_IP:6789 check
    server $NODE3_NAME $NODE3_IP:6789 check
EOF

