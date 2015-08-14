#!/bin/sh

#rev 0
#10.[a-b].[c-d].1

#set usb led on
echo 1 >  "/sys/devices/platform/leds-gpio/leds/tp-link:green:3g/brightness"

a=31
b=254
c=0
d=254

randa=$(tr -cd 1-9 </dev/urandom | head -c 6)
randb=$(tr -cd 1-9 </dev/urandom | head -c 6)

x=$(($randa % (($b+1-$a))+$a))
y=$(($randb % (($d+1-$c))+$c))


#ip=10.20.40.1
ip="10.$x.$y.1"

mask=255.255.255.0
cidrmask=24
boro=boro
nh=NYC
address=DefaultSt
nodeid=1

#node=$(uci get qmp.node.community_node_id)
mac=$(ip link show eth0 | awk '/ether/ {print $2}' | sed s/://g)
node=${mac:8}
#devname="$boro-$nh-$address-$nodeid"
devname="nycmesh"
hostname="$devname-$node"
#ssid="nycmesh $nh $address"
ssid="nycmesh $node"

board=$(cat /tmp/sysinfo/board_name)
if [ "$board" = "nanostation-m" ]; then
	channel=165
elif [ "$board" = "nanostation-m-xw" ]; then
	channel=165
else
        channel=6
fi

uci set qmp.roaming.ignore=1
uci set qmp.networks.disable_lan_dhcp=0
uci set qmp.networks.lan_address="$ip"
uci set qmp.networks.lan_netmask="$mask"
uci set qmp.networks.bmx6_ipv4_address="$ip/$cidrmask"
uci set qmp.node.community_id="$devname"
uci set system.@system[0].hostname="$hostname"

uci set qmp.@wireless[0].mode='adhoc_ap'
uci set wireless.wlan0.mode='adhoc_ap'
uci set wireless.wlan0.ssid='qMp'
uci set wireless.wlan0ap.ssid="$ssid"
uci set qmp.@wireless[0].channel="$channel"
uci set wireless.radio0.channel="$channel"
uci set qmp.@wireless[0].txpower=30
uci set wireless.radio0.txpower=30

echo "qmp mesh" > /etc/mdns/domain4
echo "qm6 mesh6" > /etc/mdns/domain6

uci commit

#configure tinc
/etc/nycmesh/tinc_conf.sh

#add cron for tunnel check
(crontab -l ; echo "* * * * * /etc/nycmesh/check_tunnel.sh")| crontab -
#add cron to push key
(crontab -l ; echo "* * * * * /etc/nycmesh/tinc_putkey.sh")| crontab -

#firewall rules
echo "#block access to internal lan" >> /etc/firewall.user
echo "iptables -I FORWARD -d 192.168.0.0/16 -j DROP" >> /etc/firewall.user 
echo "iptables -I FORWARD -d 172.16.0.0/12 -j DROP" >> /etc/firewall.user
echo "iptables -I FORWARD -o eth+ -d 10.0.0.0/8 -j DROP" >> /etc/firewall.user

#keep /etc/nycmesh during upgrades
echo "/etc/nycmesh" >> /etc/sysupgrade.conf

#set usb led off
echo 0 >  "/sys/devices/platform/leds-gpio/leds/tp-link:green:3g/brightness"
