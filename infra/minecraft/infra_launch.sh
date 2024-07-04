#!/usr/bin/bash

set -e

# * Get info about default VPC in region
# * Create DNS zone and AWS certificate
terraform apply -auto-approve

#sleep 5

# Rotate backups
if test -f "server/saves_backup/saves.tar.gz"; then
  BACKUPS_COUNTER=$(ls -la server/saves_backup | wc -l)
  mv server/saves.tar.gz "server/saves_backup/saves_${BACKUPS_COUNTER}.tar.gz"
  mv server/saves_backup/saves.tar.gz server/
fi
# Settings up new gitlab host
ansible-playbook -i server/hosts server/playbook_minecraft_apply_restore.yaml

exit 0