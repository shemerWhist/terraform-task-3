

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

  vpn_group_sg_id = module.sg.vpn_group_sg_id

}

module "ec2" {
  source = "./modules/ec2"
  instance_type = var.type
  key = var.key
  private_vpc1_sg_id = module.sg.private_vpc1_sg_id
  private_vpc2_sg_id = module.sg.private_vpc2_sg_id
  public_vpc1_sg_id  = module.sg.public_vpc1_sg_id
  vpc1_private_subnets = module.vpc.vpc1_private_subnets
  vpc2_private_subnets = module.vpc.vpc2_private_subnets
  vpc1_public_subnets  = module.vpc.vpc1_public_subnets
  
}

module "sg" {
  source = "./modules/security-groups"
  
  vpc1_id = module.vpc.vpc1.vpc_id
  vpc2_id = module.vpc.vpc2.vpc_id
  vpc1-cidr-block = var.vpc1_cidr_block
  vpc2-cidr-block = var.vpc2_cidr_block

}

