docker run -d --name prometheus \
    -p 9090:9090 \
    -v $HOME/ceph/prometheus.yml:/etc/prometheus/prometheus.yml \
    -v $HOME/ceph/prometheus-data:/prometheus-data \
    prom/prometheus
