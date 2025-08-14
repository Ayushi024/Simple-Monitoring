#!/bin/bash
sudo pkill netdata
sudo apt remove --purge netdata -y
sudo rm -rf /etc/netdata /var/lib/netdata /var/cache/netdata
