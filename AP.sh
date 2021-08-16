#!/bin/bash
#ethernet mac_address extract from ifconfig
MAC_ADDR=$( sudo ifconfig |awk '/ether/{print $2}'| head -1) 

#slicing of mac_address
FINAL_MAC_ADDR="${MAC_ADDR:12}"  
LOGINPASSWORD="${MAC_ADDR:9}"
AP_PASSWORD="AP@""${FINAL_MAC_ADDR//:}"#""

#interface device name 
INTERFACE=$( sudo iw dev |awk '/Interface/{print $2}'|tail -1)
  
#config.txt path                           
FILE=/home/letsving/config.txt
#starting AP point
sudo create_ap $INTERFACE $INTERFACE Ving_$FINAL_MAC_ADDR $AP_PASSWORD &
sleep 3

#AP_IP_address
AP_IP=$( sudo ifconfig |awk '/inet/{print $2}'| head -1)
if [ ! -f "$FILE" ]; then
#creating text file 
echo "SSID=Ving_"$FINAL_MAC_ADDR>config.txt
echo "AP_PASSWORD="$AP_PASSWORD>>config.txt
echo "AP_IP="$AP_IP>>config.txt
echo "LOGIN="admin >>config.txt
echo "LOGINPASSWORD="Ving@""${LOGINPASSWORD//:}"">>config.txt
echo "config.txt done"
fi

