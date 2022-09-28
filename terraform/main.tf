

module "vpc" {
  source = "./modules/vpc"

  region = var.region

  vpc1_cidr_block = var.vpc1_cidr_block
  vpc2_cidr_block = var.vpc2_cidr_block

  pub_vpc1_sub_cidr = var.pub_vpc1_sub_cidr
  prv_vpc1_sub_cidr = var.prv_vpc1_sub_cidr
  prv_vpc2_sub_cidr = var.prv_vpc2_sub_cidr

  vpc_peer_owner_id = var.vpc_peer_owner_id
  vpc_peering_namespace = var.vpc_peering_namespace

}

# module "vpn" {
  
# }

