```
  _       _                          __  __                 
 | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
 | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
 | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
 |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
```
#TO install CEPH mimic 13.2.2 on coreos

* [step 1:]
    download related files:


* [step 2:]
    vim CONFIG


* [step 3:]
    clone corebase2 kvm & config IP & add one virtual disk.
    (see clone_coreos/clone_machine.sh)

* [step 4:]
    sh install.sh all


* [step 5:]
    browse svc-index.html to enjoy CEPH


# more usage:
```
usage: install.sh [OPTION]
OPTIONS:
        p|prepare      :prepare ceph.tgz .etc.
        p1|pmonitor    :prepare monitor.tgz.
        p2|haprepare   :prepare ha.tgz.
        keepalived     :install keepalived.
        haproxy        :install haproxy.
        mon1           :install mon on node1.
        mon2           :install mon on node2,3.
        osd            :install osd on all nodes.
        mgr            :install mgr on all nodes.
        rgw            :install rgw on node3:7000.
        mds            :install mds on node2.
        rbd            :install rbd_mirror.
        dashboard      :install dashboard.
        monitor        :install prometheus/grafana/exporter.
        status         :get ceph status&svc.
        reset          :when reinstall, delete all.
        start          :start all ceph container in cluster.
        all            :install all components.
```
#END.
