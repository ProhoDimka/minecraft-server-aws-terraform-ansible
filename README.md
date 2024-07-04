# Minecraft server terraform+ansible
Main purpose of this project to keep your wallet and mental health in good condition.
You can apply minecraft java server and play with your family and friends, 
but after your will finish to play you can backup it and destroy expensive resources to save your money.  

## Prerequisites
1. Software and credentials:
   * You have an [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html), [TERRAFORM](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli), and [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed
   * You have an [AWS account credentials](https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-files.html) and AWS_PROFILE is set.
2. Remote state was setup in terraform.tf:
   * region variable has the same value from variables.tf file
   * bucket,key,dynamodb_table has the same values from shell script variables:
```shell
# CREATE RESOURCE FOR REMOTE STATE AND STATE LOCKING
AWS_REGION=ap-south-1
AWS_TERRAFORM_BUCKET_NAME=terraform-states-minecraft-example-com
AWS_DYNAMODB_TABLE=state-locking

aws s3api create-bucket \
  --region ${AWS_REGION} \
  --bucket ${AWS_TERRAFORM_BUCKET_NAME} \
  --create-bucket-configuration LocationConstraint=${AWS_REGION}

aws dynamodb create-table \
         --region ${AWS_REGION} \
         --table-name ${AWS_DYNAMODB_TABLE} \
         --attribute-definitions AttributeName=LockID,AttributeType=S \
         --key-schema AttributeName=LockID,KeyType=HASH \
         --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1
```
3. Set variable var.vpc_id from your AWS account
4. Set variable var.account_domain_init_name. 
   * **You should already have an AWS hosted domain zone "example.com"** 
      where you will manually add NS records after minecraft DNS zone "minecraft.example.com" will be applied.
   * It will be one time manual action because destroy script wouldn't delete applied DNS records resources.
5. Set variable var.user_key_path to add your ssh public key to the server. It will necessary for ansible scripts.
6. Make scripts executable:
```shell
PROJECT_ROOT_DIR=${PWD} # ROOT DIR OF GIT PROJECT
cd ${PROJECT_ROOT_DIR}/infra/minecraft
chmod +x infra_launch.sh
chmod +x infra_destroy.sh
chmod +x server/scripts/*.sh
```

## Options
1. You can change **java installation version** in 1_install_java.sh file
2. You can change **MINECRAFT_SERVER_RELEASE** in 2_launch_server.sh file
3. You can change **any parameters** in var.instance object you want, but if you will change instance type, also change 2_launch_server.sh with ExecStart parameters "-Xmx5G -Xms5G -XX:SoftMaxHeapSize=4G"

## Apply
```shell
PROJECT_ROOT_DIR=${PWD} # ROOT DIR OF GIT PROJECT
cd ${PROJECT_ROOT_DIR}/infra/minecraft
./infra_launch.sh
```
This script will:
1. Apply infra
2. upload saves.tar.gz to remote ~/.minecraft_server 
3. install java
4. start server
    * download server
    * untar saves
    * start server

## Backup and Destroy
```shell
PROJECT_ROOT_DIR=${PWD} # ROOT DIR OF GIT PROJECT
cd ${PROJECT_ROOT_DIR}/infra/minecraft
./infra_destroy.sh
```
This script will:
1. Backup saves from the server
2. Destroy expensive infra like EC2 instance, but will not delete DNS Zone
