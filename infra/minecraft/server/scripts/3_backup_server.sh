#!/usr/bin/bash

# Server host
cd .minecraft_server || exit 1
sudo systemctl stop minecraft.service
sudo systemctl status minecraft.service
rm -f saves.tar.gz
tar czf saves.tar.gz -P saves

exit 0