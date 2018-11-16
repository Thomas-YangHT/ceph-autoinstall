source ./CONFIG
a=`ssh $REMOTE_USER@$NODE1_IP  docker exec mgr ceph mgr services|grep dashboard|grep -Po ".*https://\K.*:"`
[ "$a" = "${NODE1_NAME}:" ] && ACTIVE_MGR_IP=$NODE1_IP
[ "$a" = "${NODE2_NAME}:" ] && ACTIVE_MGR_IP=$NODE2_IP
[ "$a" = "${NODE3_NAME}:" ] && ACTIVE_MGR_IP=$NODE3_IP

cat <<EOF >svc-ceph.html
<h1>service目录</h1>
<ul>
	  <li><a href='https://$ACTIVE_MGR_IP:8443  '>dashboard   </a></li>
	  <li><a href='http://$NODE1_IP:3000        '>grafana     </a></li>
	  <li><a href='http://$NODE1_IP:9090        '>prometheus  </a></li>
	  <li><a href='http://$NODE3_IP:7480        '>rgw         </a></li>
	  <li><a href='tcp://$NODE1_IP:6789         '>[cephfs:]    modprobe rbd;  mkdir /mnt/mycephfs;  mount -t ceph $NODE1_IP:6789,$NODE2_IP:6789,$NODE3_IP:6789:/ /mnt/mycephfs -o name=admin,secret=`ssh  $REMOTE_USER@$NODE1_IP docker exec mon ceph auth get-key client.admin`
			</a></li>
</ul>
EOF

#scp svc-ceph.html <to a web hosts>
