#!/bin/sh
#10.a-b.c-d.1

a=31
b=254
c=0
d=254

randa=$(tr -cd 1-9 </dev/urandom | head -c 6)
randb=$(tr -cd 1-9 </dev/urandom | head -c 6)

x=$(($randa % (($b+1-$a))+$a))
y=$(($randb % (($d+1-$c))+$c))

ip="10.$x.$y.1"

mac=$(ip link show eth0 | awk '/ether/ {print $2}' | sed s/://g)
node=${mac:8}
devname="nycmesh"
hostname="$devname-$node"
ssid="nycmesh $node"

uci set system.@system[0].hostname="$hostname"
uci set qmp.node.community_id="$devname"

uci set qmp.@wireless[0].channel='6'
uci set wireless.radio0.channel='6'

uci set qmp.networks.bmx6_ipv4_address="$ip/24"
uci set qmp.roaming.ignore='1'
uci set qmp.networks.lan_address="$ip"
uci set qmp.networks.lan_netmask='255.255.255.0'
uci set qmp.networks.bmx6_ipv4_address="$ip/24"
uci set qmp.@wireless[0].mode='adhoc_ap'

uci set bmx6.general.tun4Address="$ip/24"
uci set bmx6.tmain.tun4Address="$ip/24"

uci set network.lan.ipaddr="$ip"
uci set network.lan.netmask='255.255.255.0'


uci set nodogsplash.@instance[0].enabled='1'
uci set nodogsplash.@instance[0].gatewayname='NYC Mesh Splash'
uci del_list nodogsplash.@instance[0].authenticated_users='block to 10.0.0.0/8'
uci add_list nodogsplash.@instance[0].authenticated_users='block to 172.16.0.0/12'
uci add_list nodogsplash.@instance[0].authenticated_users='allow all to 10.0.0.0/8'

#temporary until we decide what ports
uci add_list nodogsplash.@instance[0].authenticated_users='allow all'

uci commit
qmpcontrol configure_wifi

uci set wireless.wlan0ap.ssid="$ssid"

#this doesn't seem to be working as intended
uci set gateways.inet4.ignore='0'

uci commit

/etc/init.d/network restart

echo "qmp mesh" > /etc/mdns/domain4
echo "qm6 mesh6" > /etc/mdns/domain6

#configure tinc
/etc/nycmesh/tinc_conf.sh

#add cron for tunnel check
(crontab -l ; echo "* * * * * /etc/nycmesh/check_tunnel.sh")| crontab -
#add cron to push key
(crontab -l ; echo "* * * * * /etc/nycmesh/tinc_putkey.sh")| crontab -

#firewall rules
echo "#block access to private address space" >> /etc/firewall.user
echo "iptables -I FORWARD -d 192.168.0.0/16 -j DROP" >> /etc/firewall.user
echo "iptables -I FORWARD -d 172.16.0.0/12 -j DROP" >> /etc/firewall.user
echo "iptables -I FORWARD -o eth+ -d 10.0.0.0/8 -j DROP" >> /etc/firewall.user

echo "#allow only SSH and tinc on WAN" >> /etc/firewall.user
echo 'wan=$(uci get qmp.interfaces.wan_devices)' >> /etc/firewall.user
echo 'iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT' >> /etc/firewall.user
echo 'iptables -A INPUT -p tcp --dport 22 -j ACCEPT -i $wan' >> /etc/firewall.user
echo 'iptables -A INPUT -p tcp --dport 655 -j ACCEPT -i $wan' >> /etc/firewall.user
echo 'iptables -A INPUT -p udp --dport 655 -j ACCEPT -i $wan' >> /etc/firewall.user
echo 'iptables -A INPUT -j DROP -i $wan' >> /etc/firewall.user

#keep /etc/nycmesh during upgrades
echo "/etc/nycmesh" >> /etc/sysupgrade.conf

