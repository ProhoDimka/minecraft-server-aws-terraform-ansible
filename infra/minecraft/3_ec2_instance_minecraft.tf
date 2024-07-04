module "ec2_instance_minecraft" {
  source                 = "../../modules/ec2_instance"
  region                 = var.region
  vpc_id                 = module.vpc_default.vpc_id
  subnet_id              = module.vpc_default.vpc_subnets_public[0].id
  zone_id_for_dns_record = module.account_dns_zone.zone_id
  account_domain_name    = module.account_dns_zone.zone_id_name

  create_ansible_hosts   = true
  add_iam_creds_to_hosts = false
  use_custom_ip_port     = false

  # Warning for conflicts in case associate_public_ip_address = true
  zone_records = []

  user_key_path = {
    private = "/home/user/.ssh/id_rsa"
    public  = "/home/user/.ssh/id_rsa.pub"
  }

  instance = {
    name                        = "server"
    type                        = "t4g.large"
    user                        = "ubuntu"
    aws_ami_id                  = "ami-0454f8914fe93b6ad"
    use_existing_aws_ssh_key    = false
    aws_ssh_key_name            = "minecraft_server_ssh"
    associate_public_ip_address = true
    storage = {
      size = 30
      type = "gp2"
      additional_volumes = []
    }
    security_groups_rules = {
      ingress = [
        {
          from_port = 22
          to_port   = 22
          protocol  = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        },
        {
          from_port = 25565
          to_port   = 25565
          protocol  = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        },
      ]
      egress = [
        {
          from_port = 0
          to_port   = 0
          protocol  = "-1"
          cidr_blocks = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
        }
      ]
    }
    iam_username = "iam_user_minecraft_server"
    iam_additional_policy_attachment = []
    iam_additional_user_policy = []
    lb_tg_attachment = []
  }
}