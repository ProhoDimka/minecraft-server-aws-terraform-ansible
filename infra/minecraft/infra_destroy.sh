#!/usr/bin/bash

set -e

# * Get info about default VPC in region
# * Create DNS zone and AWS certificate

# Settings up new gitlab host
ansible-playbook -i server/hosts server/playbook_minecraft_destroy_backup.yaml

#read "Check if backup has good condition.."

terraform destroy -auto-approve \
  -target module.ec2_instance_minecraft

exit 0