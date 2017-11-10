#!/bin/sh
### DEFAULTS ###
VHID=1
UPSCRIPT=/usr/libexec/ucarp/vip-up
DOWNSCRIPT=/usr/libexec/ucarp/vip-down
INTERFACE=eth0

### FROM CONFIGS ###
for c in /etc/ucarp/*.conf; do
	source $c
done
IP=$(ifconfig $INTERFACE | grep inet | grep -v inet6 | awk '{print $2}')

### CHECK AND RUN ###
[ -n "$INTERFACE" -a -n "$IP" -a -n "$VHID" -a -n "$PASSWORD" -a -n "$VIP_ADDRESS" -a -n "$UPSCRIPT" -a -x "$UPSCRIPT" -a -n "$DOWNSCRIPT" -a -x "$DOWNSCRIPT" ] && \
	/usr/sbin/ucarp \
		--interface=$INTERFACE --srcip=$IP \
		--vhid=$VHID --pass=$PASSWORD \
		--addr=$VIP_ADDRESS \
		--upscript=$UPSCRIPT --downscript=$DOWNSCRIPT \
		--facility=stdout --shutdown --preempt --advskew=1 || \
	echo "Some parameters missed! Check configs!"
