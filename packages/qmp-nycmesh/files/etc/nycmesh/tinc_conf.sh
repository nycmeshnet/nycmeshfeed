#!/bin/sh
#rev 0
 
#define network
network='nycmesh'
tincdir="/etc/tinc/$network"
tincconf="$tincdir/tinc.conf"
mac=$(ip link show eth0 | awk '/ether/ {print $2}' | sed s/://g)
 
#create initial configuration
createconf(){
cat >"$tincdir/tinc.conf" << EOL
Name = $mac
AddressFamily = any
Interface = tap0
Mode = switch
ConnectTo = tunnelnycmesh
AutoConnect = Yes
EOL
}
 
#generate keys
genkey(){                                              
version=$(tincd --version | awk '/version/ {print $3}')
major=${version:0:3}                                  
if [ "$major" = "1.0" ]; then                          
  echo "1.0.x"                                        
  tincd -K2048 -n $network </dev/null                  
fi                                                    
if [ "$major" = "1.1" ]; then                          
  echo "1.1.x"                                        
  tinc -n $network generate-keys 2048 </dev/null      
fi                                                    
}
 
#check if tinc 1.0 -> 1.1
checkupgrade(){
echo "checking upgrade"
version=$(tincd --version | awk '/version/ {print $3}')
major=${version:0:3}
name=$(awk '/[nN]ame/ {print $3}' $tincconf)
echo $name
if [ "$major" = "1.1" ]; then
  if grep -q "Ed25519PublicKey" $tincdir/hosts/$name; then
    echo "Ed25519PublicKey found"
  else
    echo "Ed25519PublicKey not found"
    tinc -n $network generate-ed25519-keys
    tinc -n $network set AutoConnect Yes
    (crontab -l ; echo "* * * * * /etc/nycmesh/tinc_putkey.sh")| crontab -
  fi
else
  echo "version 1.0.x, not an upgrade"
fi
}
 
#main script
mkdir -p "$tincdir/hosts"
 
if [ -f "$tincdir/tinc.conf" ]; then
  echo "tinc already configured"
  checkupgrade
else
  echo "not conf"
  createconf
  genkey
fi
 
#save tinc settings across upgrades
if grep -q tinc /etc/sysupgrade.conf; then
  echo "/etc/tinc" >> /etc/sysupgrade.conf
fi
