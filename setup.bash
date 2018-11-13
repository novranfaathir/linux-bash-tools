#!/bin/bash
# Setup :
# git clone https://github.com/panophan/infogempa-linux.git
# cd infogempa-linux/
# chmod +x setup.bash
# ./setup.bash

mkdir /opt/infogempa-linux 2> /tmp/infogempa.log
touch /opt/infogempa-linux/infogempa.bash 2> /tmp/infogempa.log
cat infogempa.bash > /opt/infogempa-linux/infogempa.bash 2> /tmp/infogempa.log
chmod 755 /opt/infogempa-linux/infogempa.bash 2> /tmp/infogempa.log
ln -sf /opt/infogempa-linux/infogempa.bash /usr/bin/infogempa 2> /tmp/infogempa.log
ln -sf /opt/infogempa-linux/infogempa.bash /usr/local/bin/infogempa 2> /tmp/infogempa.log

if [[ -z /tmp/infogempa.log ]];
then
	echo "OK: INSTALL SUCCESS!"
	echo "Command: infogempa"
else
	echo "INSTALL FAILED!"
	echo "--- LOG ERROR ---"
	cat /tmp/infogempa.log
	echo "-----------------"
	rm /tmp/infogempa.log
fi
