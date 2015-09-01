#!/bin/sh
help() {
echo "Commands"
echo "set name <node name>"
echo "set ip <node ip>"
echo "set ssid <node ssid> (ssid needs to be in quotes if there are spaces)"
}

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Error"
  help
fi

if [ "$1" = "set" ] && [ "$2" = "name" ] && [ -n "$3" ]; then
  echo "Setting name: $3"
  devname="$3"
  nodeid=$(uci get qmp.node.community_node_id)
  uci set qmp.node.community_id="$devname"
  uci set system.@system[0].hostname="$devname-$nodeid"
  echo $devname-$nodeid > /proc/sys/kernel/hostname
  uci commit
  echo "restarting bmx6"
  /etc/init.d/bmx6 restart
fi

if [ "$1" = "set" ] && [ "$2" = "ip" ] && [ -n "$3" ]; then
  ip="$3"
  echo "Setting ip: $3"
  uci set bmx6.general.tun4Address="$ip/24"
  uci set bmx6.tmain.tun4Address="$ip/24"
  uci set network.lan.ipaddr="$ip"
  uci set qmp.networks.bmx6_ipv4_address="$ip/24"
  uci set qmp.networks.lan_address="$ip"
  uci commit
  /etc/init.d/bmx6 restart
  /etc/init.d/network reload
fi

if [ "$1" = "set" ] && [ "$2" = "ssid" ] && [ -n "$3" ]; then
  ssid="$3"
  echo "Setting ssid: nycmesh $ssid"
  uci set wireless.wlan0ap.ssid="nycmesh $ssid"
  /etc/init.d/network reload
fi
