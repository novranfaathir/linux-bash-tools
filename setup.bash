#!/bin/bash
# cd infogempa-linux/
# chmod +x setup.bash
# ./setup.bash


mkdir /opt/infogempa-linux 2> /tmp/infogempa.log
touch /opt/infogempa-linux/infogempa.bash 2> /tmp/infogempa.log
cat infogempa.bash > /opt/infogempa-linux/infogempa.bash 2> /tmp/infogempa.log
chmod 755 /opt/infogempa-linux/infogempa.bash 2> /tmp/infogempa.log
ln -s /opt/infogempa-linux/infogempa.bash /usr/bin/infogempa 2> /tmp/infogempa.log
ln -s /opt/infogempa-linux/infogempa.bash /usr/local/bin/infogempa 2> /tmp/infogempa.log

if [[ -z /tmp/infogempa.log ]];
then
	echo "OK: INSTALL SUCCESS!"
	echo "Command: infogempa"
else
	echo "INSTALL FAILED!"
	echo "--- LOG ERROR ---"
	cat /tmp/infogempa.log
	echo "-----------------"
fi
