![](https://img.shields.io/badge/Dist-CoreOS-blue.svg)  ![](https://img.shields.io/badge/Storage-CEPH-brightgreen.svg)  ![](https://img.shields.io/badge/Proxy-IPVS-orange.svg)  ![](https://img.shields.io/badge/Haproxy-LB-yellow.svg) ![](https://img.shields.io/badge/Keepalived-HA-yellow.svg) 
```
  _       _                          __  __                 
 | |     (_)  _ __    _   _  __  __ |  \/  |   __ _   _ __  
 | |     | | | '_ \  | | | | \ \/ / | |\/| |  / _` | | '_ \ 
 | |___  | | | | | | | |_| |  >  <  | |  | | | (_| | | | | |
 |_____| |_| |_| |_|  \__,_| /_/\_\ |_|  |_|  \__,_| |_| |_|
```
# TO install CEPH mimic 13.2.2 on CoreOS
-----
## [step 1:] download related files:
  * [coreosbase2.tgz](https://pan.baidu.com/s/141I6ctxuGtFfiD8tRHfz_g)
  * [ceph.tgz](https://pan.baidu.com/s/191LYj4DL3wm2li5LabeDEw)
  * [monitor.tgz](https://pan.baidu.com/s/1mooOZsEjsf4q_O4Zn5s5jA)
  * [ha.tgz](https://pan.baidu.com/s/1Cj_BAiohKnZOi2MKCEX10g)
  * [install SHELL]：git clone https://github.com/Thomas-YangHT/ceph-autoinstall.git

## [step 2:]  vim CONFIG

<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/c1.png" width="500">


## [step 3:] clone KVM
  *  clone corebase2 kvm & config IP & add one virtual disk.
```
   kvm define coreosbase2.xml
   cd clone_coreos; sh -x clone_machine.sh
```
## [step 4:] INSTALL
    `sh install.sh all`
    
    [![asciicast](https://asciinema.org/a/LYqagdkbT3ti79QuQttX5nXr6.svg)](https://asciinema.org/a/LYqagdkbT3ti79QuQttX5nXr6)
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/c2.png" width="800">

## [step 5:] Check & Use
    * browse svc-index.html to enjoy CEPH
    ` sh install.sh status `
    * modify grafana's datasource prometheus IP as node1's IP
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/c3.png" width="800">
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/c4.png" width="800">
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/c5.png" width="800">
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/c6.png" width="800">
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/c7.png" width="800">
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/c8.png" width="800">

# More Usage:
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
-----
# weixin public accunt: [LinuxMan]
* [linux command HELP,try input some cmd, such as lsof]
<img src="https://github.com/Thomas-YangHT/ceph-autoinstall/raw/master/pics/linuxman.png" width="500">

