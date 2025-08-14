#!/bin/bash
echo "Generating CPU load..."
sudo apt install stress -y
stress --cpu 2 --timeout 30
