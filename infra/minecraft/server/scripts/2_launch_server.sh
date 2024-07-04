#!/usr/bin/bash

# 1.21 = 450698d1863ab5180c25d7c804ef0fe6369dd1ba
MINECRAFT_SERVER_RELEASE=https://piston-data.mojang.com/v1/objects/450698d1863ab5180c25d7c804ef0fe6369dd1ba/server.jar

# Server host
cd .minecraft_server || exit 1
tar xf saves.tar.gz
wget "${MINECRAFT_SERVER_RELEASE}"
sudo chmod u+x server.jar
cat <<EOF | sudo tee /lib/systemd/system/minecraft.service
[Unit]
Description=start and stop the minecraft.service

[Service]
WorkingDirectory=/home/ubuntu/.minecraft_server
User=ubuntu
Group=ubuntu
Restart=on-failure
RestartSec=20
ExecStart=java -Xmx5G -Xms5G -XX:SoftMaxHeapSize=4G -XX:+UnlockExperimentalVMOptions -XX:+UseZGC -jar server.jar --nogui --world saves/Pot_spot

[Install]
WantedBy=multi-user.target
EOF
cat <<EOF | tee eula.txt
eula=true
EOF
# --port 33149 \

sudo systemctl daemon-reload
sudo systemctl enable minecraft.service
sudo systemctl start minecraft.service
sudo systemctl status minecraft.service

exit 0