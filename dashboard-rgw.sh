source $HOME/ceph/CONFIG
docker exec mon radosgw-admin user create --uid=123 --display-name=rgw_adm  --system
#记下输出KEY或由下面命令查
docker exec mon radosgw-admin user info --uid=123
a=(`docker exec mon radosgw-admin user info --uid=123|grep -Po "access_key\":\K.*|secret_key\":\K.*"|sed -e 's/"//g' -e 's/,//'|xargs`)
#            "access_key": "V4J9G5OGVYCJWIRIGSL1",
#            "secret_key": "zt6nLe7j4lukAXXm5rSqgAIZxZN6I6Ie6cC3SOaP"
#设定
docker exec mon ceph dashboard set-rgw-api-access-key ${a[0]}
docker exec mon ceph dashboard set-rgw-api-secret-key ${a[1]}
docker exec mon ceph dashboard set-rgw-api-host $NODE3_IP
docker exec mon ceph dashboard set-rgw-api-port 7480
# docker exec mon ceph set-rgw-api-scheme https
docker exec mon ceph dashboard set-rgw-api-user-id 123
# 查
docker exec mon ceph dashboard get-rgw-api-scheme
docker exec mon ceph dashboard get-rgw-api-host
docker exec mon ceph dashboard get-rgw-api-port
docker exec mon ceph dashboard get-rgw-api-user-id
docker exec mon ceph dashboard get-enable-browsable-api
#重启dashboard
docker exec mgr  ceph mgr module disable dashboard
docker exec mgr  ceph mgr module enable dashboard
