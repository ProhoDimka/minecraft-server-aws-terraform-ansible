#!/usr/bin/bash

wget -q -O - https://download.bell-sw.com/pki/GPG-KEY-bellsoft | gpg --dearmor \
    | sudo tee /etc/apt/keyrings/GPG-KEY-bellsoft.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/GPG-KEY-bellsoft.gpg arch=$(dpkg --print-architecture)] https://apt.bell-sw.com/ stable main" \
    | sudo tee /etc/apt/sources.list.d/bellsoft.list
sudo apt update
sudo apt install bellsoft-java22 -y

exit 0