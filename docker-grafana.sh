sudo chmod -R a+w ceph/grafana
docker run --name grafana \
-d \
-p 3000:3000 \
-v $HOME/ceph/grafana/grafana:/var/lib/grafana \
-v $HOME/ceph/grafana/grafana.ini:/etc/grafana/grafana.ini \
grafana/grafana:5.2.4
