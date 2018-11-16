source ./CONFIG
cat <<EOF > hosts
$VIP_IP ceph ceph.yunwei.edu
$NODE1_IP $NODE1_NAME 
$NODE2_IP $NODE2_NAME 
$NODE3_IP $NODE3_NAME 
EOF
