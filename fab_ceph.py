from fabric.api import *

#for ha
def prepare_ha():
    local('sh haproxy_conf.sh')
    local('sh hosts_conf.sh')
    put('ha.tgz', '')
    put('haproxy.cfg','ceph/haproxy.cfg')
    put('hosts','ceph/hosts')
    run('tar zxvf ha.tgz -C ceph')
    run('echo -e "haproxy.tar\n keepalived.tar"|awk \'{print "docker load <ceph/"$1}\'|sh')
    run('[ -f hosts.bak ] || cp /etc/hosts hosts.bak;cat hosts.bak ceph/hosts >hosts.tmp;sudo cp hosts.tmp /etc/hosts')

#for ha
def keepalived():
    run('docker rm keepalived -f;pwd')
    run('sudo modprobe ip_vs ip_vs_rr ip_vs_wrr ip_vs_sh')
    run('cd ceph;sh docker-keepalived.sh')

#for ha
def haproxy():
    run('docker rm haproxy -f;pwd')
    run('cd ceph;sh docker-haproxy.sh')

def prepare():
    local('sh prometheus.yml.sh')
    local('tar zcvf config.tgz docker*sh CONFIG ceph.conf.add dashboard-rgw.sh grafana prometheus.yml haproxy.cfg hosts')
    put('config.tgz','')
    put('ceph.tgz','')
    run('mkdir ceph;tar zxvf config.tgz -C ceph;tar zxvf ceph.tgz -C ceph')
    run('ls ceph/*.tar|awk \'{print "docker load <"$1}\'|sh')

def pmonitor():
    put('monitor.tgz','')
    run('tar zxvf monitor.tgz -C ceph')
    run('ls ceph/{prome*tar,gra*tar,*export*tar}|awk \'{print "docker load <"$1}\'|sh')
    
def mon1():
    run('sh ceph/docker-mon.sh;echo "waiting keyring generate...";\
while [ 1 ]; do A=`sudo cat /etc/ceph/ceph.mon.keyring |wc -l`; \
[ "$A" -ge 22 ] && break; done')
    run('[ -f ./ceph/ceph.conf.bak ] || sudo cp /etc/ceph/ceph.conf ./ceph/ceph.conf.bak && \
cat ceph/ceph.conf.bak ceph/ceph.conf.add >ceph/ceph.conf')
    run('sudo cp ceph/ceph.conf /etc/ceph/')
    run('sudo tar zcvf cephetc.tgz /etc/ceph')
    run('sudo tar zcvf cephvar.tgz /var/lib/ceph')
    get('cephetc.tgz','./cephetc.tgz')
    get('cephvar.tgz','./cephvar.tgz')

def mon2():
    put('cephetc.tgz')
    put('cephvar.tgz')
    run('sudo tar zxvf cephetc.tgz -C /etc --strip-components 1')
    run('sudo tar zxvf cephvar.tgz -C /var/lib --strip-components 2')
    run('sh ceph/docker-mon.sh')

def osd():
    run('sh ceph/docker-osd.sh')

def mds():
    run('sh ceph/docker-mds.sh')

def rgw():
    run('sh ceph/docker-rgw.sh')

def mgr():
    run('sh ceph/docker-mgr.sh')

def rbd():
    run('sh ceph/docker-rbd.sh')

def dashboard():  #7000
    run('docker exec mgr ceph mgr module enable dashboard')
    run('docker exec mgr ceph dashboard create-self-signed-cert')
    run('docker exec mgr ceph dashboard set-login-credentials admin admin')
    run('docker exec mgr ceph mgr module disable dashboard')
    run('docker exec mgr ceph mgr module enable  dashboard')

def dashboard_rgw(): 
    run('sh ceph/dashboard-rgw.sh')

def prometheus(): #9283/nodes  9090/node1
    run('docker exec mgr ceph mgr module enable prometheus')
    run('sh ceph/docker-prometheus.sh')

def node_exporter(): #9128
    run('sh ceph/docker-exporter.sh')

def grafana():  #3000
    run('sh ceph/docker-grafana.sh')

def status():
    run('cat /etc/motd;docker exec mon ceph -v;uname -a')
    run('docker exec mon ceph -s')
    run('docker exec mgr ceph mgr services')

def reset():
    run('A=`docker ps -a|grep -P "mon|osd|mds|mgr|rgw"`;[ -n "$A" ] && echo $A|awk \'{print $1}\'|xargs docker rm -f || echo 0')
    run('sudo rm -f ceph/ceph.conf.bak')
    run('sudo rm -rf /etc/ceph')
    run('sudo rm -rf /var/lib/ceph')
    run('source ./ceph/CONFIG;sudo dd if=/dev/zero of=${OSD_DEVICE} bs=1M')

def start():
    run('sudo modprobe ip_vs ip_vs_rr ip_vs_wrr ip_vs_sh')
    run('docker start mon;sleep 10')
    run('docker start mgr;sleep 5')
    run('docker start osd;sleep 5')
    run('docker ps -a|grep Exited|awk \'{print $1}\'|xargs docker start ')

def reboot():
    run('echo "reboot $HOSTNAME";sudo reboot;')

