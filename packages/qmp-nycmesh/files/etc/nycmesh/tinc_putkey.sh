#/bin/sh

wget --spider http://www.google.com >/dev/null 2>&1
if [ "$?" != 0 ]; then
  echo "No Internet!"
  internet=0
else
  echo "Internet"
  internet=1
fi


if [ -f /etc/nycmesh/.tinc_uploaded ]
then
echo "key already uploaded"
elif [ "$internet" = "1" ]
  then

  echo "uploading key"
 
node=$(cat /etc/tinc/nycmesh/tinc.conf |grep Name | cut -d" " -f3)
key=$(cat /etc/tinc/nycmesh/hosts/$node)
ip=$(uci get qmp.networks.lan_address)
auth="yes"
ver=1

response=$(curl -Fnode="$node" \
	-Fkey="$key" \
	-Fip="$ip" \
	-Fauth="yes" \
	-Fver="1" \
	http://themesh.nyc/publickey/putkey.php)

echo $response
if [ "$response" = "OK" ]; then
  echo "Upload successfull"
  echo "removing crontab"
  crontab -l | grep -v tinc_putkey | crontab -

else
  echo "Upload failed"
fi

else
echo "trying again later"

fi

