source ./CONFIG
ips=(`echo $NODES|sed 's/,/ /g'`)

while [ 1 ]
do
  j=0
  for i in ${ips[*]}
  do 
    A=`ssh $REMOTE_USER@$i docker ps|grep osd`
    [ -z "$A" ] && ssh $REMOTE_USER@$i docker restart osd || ((j++))
  done 
  [ "$j" -eq "${#ips[*]}" ] && break
done
