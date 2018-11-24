source ../CONFIG
sh user_data.sh

j=0
IPS=(`echo $NODES|sed 's/,/ /g'`)
for i in `echo $KVM_NAME|sed 's/,/ /g'`
do 
   virsh start $PJ-$i
   while [ 1 ] 
   do 
       ping -c 1 ${IPS[$j]}
       [ $? = 0 ] && scp user_data.$i core@${IPS[$j]}:user_data && \
       ssh core@${IPS[$j]} sudo cp user_data /var/lib/coreos-install/ && \
       break || sleep 1
   done
   ssh core@${IPS[$j]} sudo reboot 
   ((j++))
done

