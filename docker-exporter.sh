docker run -d --name node-exporter \
-v /etc/ceph:/etc/ceph \
-p 9128:9128 \
digitalocean/ceph_exporter
