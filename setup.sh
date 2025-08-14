#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl -y
bash <(curl -SsL https://my-netdata.io/kickstart.sh)
sudo nohup netdata >/dev/null 2>&1 &

