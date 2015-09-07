#!/bin/sh

#rev 0

interfaces="tap0"

for i in $interfaces
do
        echo "checking $i"

        if bmx6 -c --interfaces |grep -q $i ; then
                echo "$i found"
        else
                echo "$i not found"
                bmx6 -c -i $i
        fi
done

bmxoutput=$(bmx6 -c --interfaces |grep tap0)
mtu=$(bmx6 -c -p |grep tunMtu | awk '{print $2}')

#check mtu, needs to be lower because of vpn tunnel
echo "tunmtu: $mtu"
if [ -z "$mtu$ ] || [ "$mtu" -ne "1300" ]; then
        echo "tunnel mtu wrong, fixing"
        bmx6 -c --tunmtu 1300
else
        echo "tunnel mtu is ok"
fi

tap0ratemin=$(echo $bmxoutput | awk '{print $4}')
tap0ratemax=$(echo $bmxoutput | awk '{print $5}')
#check vpn tunnel speed, set lower than wifi / eth for better gateway election
if [ -n "$bmxoutput" ]; then
        echo "tap0ratemin: $tap0ratemin tap0ratemax: $tap0ratemax"
        if [ "$tap0ratemin" != "10000K" ]; then
                echo "fixing tap0ratemin"
                bmx6 -c -i tap0 /rateMin 10000000
        fi
        if [ "$tap0ratemax" != "10000K" ]; then
                echo "fixing tap0ratemax"
                bmx6 -c -i tap0 /rateMax 10000000
        fi
fi
