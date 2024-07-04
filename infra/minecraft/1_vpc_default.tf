module "vpc_default" {
  source                              = "../../modules/vpc_default"
  default_vpc_id                      = var.vpc_id
  region                              = var.region
  create_private_subnets_counter      = 0
  create_private_subnets_route_to_nat = false
  create_nat_gw                       = false
  nat_gw_subnets_count                = 0
}