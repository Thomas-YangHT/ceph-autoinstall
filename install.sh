#  _       _                          __  __                 
# | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
# | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
# | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
# |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
#                                                             
#

#start timestamp
D1=`date +%s`

#if no fab cmd, then install fabric
which fab;[ $? -eq 1 ] && echo "install fabric" && yum install -y fabric 
#or: pip install fabric==1.14.0

source ./CONFIG
source ./FUNCTION

#start timestamp
D1=`date +%s`

#if no fab cmd, then install fabric
which fab;[ $? -eq 1 ] && echo "install fabric" && yum install -y fabric 
#or: pip install fabric==1.14.0

case $1 in
p|prepare)
  echo "prepare..."
  func_prepare
;;
p1|pmonitor)
  echo "prepare monitor..."
  func_pmonitor
;;
mon1)
  echo "mon1"
  func_mon1
;;
mon2)
  echo "mon2"
  func_mon2
;;
osd)
  echo "osd"
  func_osd
;;
rgw)
  echo "rgw"
  func_rgw
;;
mds)
  echo "mds"
  func_mds
;;
mgr)
  echo "mgr"
  func_mgr
;;
dashboard)
  echo "dashboard"
  func_dashboard
;;
monitor)
  echo "monitor"
  func_monitor
;;
reset)
  echo "reset"
  func_reset
;;
status)
  echo "status"
  func_status
;;
start)
  echo "start"
  func_start
;;
all)
  echo "all"
  func_prepare
  func_pmonitor
  func_mon1
  func_mon2
  func_osd
  func_mgr
  func_rgw
  func_mds
  func_dashboard
  func_monitor
  func_status
;;
help|*)
  echo "usage: $0 [OPTION]"
  echo -e "OPTIONS:\
        p|prepare      :prepare ceph.tgz .etc.\n\
        p1|pmonitor    :prepare monitor tgz.\n\
        mon1           :install mon on node1.\n\
        mon2           :install mon on node2,3.\n\
        osd            :install osd on all nodes.\n\
        mgr            :install mgr on all nodes.\n\
        rgw            :install rgw on node3:7000.\n\
        mds            :install mds on node2.\n\
        dashboard      :install dashboard.\n\
        monitor        :install prometheus/grafana/exporter.\n\
        status         :get ceph status&svc.\n\
        reset          :when reinstall, delete all.\n\
        start          :start all ceph container in cluster.\n\
        all            :install all components.\n\
  "
;;
esac

#cost seconds
D2=`date +%s`
echo ALL Mission completed in $((D2-D1)) seconds

