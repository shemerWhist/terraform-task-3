
# get all the availability zones are available in this region
data "aws_availability_zones" "AZs" {
  state = "available"
}

# create the vpc
module "vpc1" {
  source = "terraform-aws-modules/vpc/aws"

  name = "shemer-vpc1"
  cidr = var.vpc1_cidr_block

  azs             = [data.aws_availability_zones.AZs.names[0], data.aws_availability_zones.AZs.names[1]]
  private_subnets = var.prv_vpc1_sub_cidr
  public_subnets  = var.pub_vpc1_sub_cidr

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Name        = "vpc1"
    Terraform   = "true"
    Environment = "${terraform.workspace}"
    Facing      = "public/private"
  }
}

module "vpc2" {
  source = "terraform-aws-modules/vpc/aws"

  name = "shemer-vpc2"
  cidr = var.vpc2_cidr_block

  azs             = [data.aws_availability_zones.AZs.names[0], data.aws_availability_zones.AZs.names[1]]
  private_subnets = var.prv_vpc2_sub_cidr
  public_subnets  = []

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Name        = "vpc2"
    Terraform   = "true"
    Environment = "${terraform.workspace}"
    Facing      = "private"
  }
}

resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_owner_id = var.vpc_peer_owner_id
  peer_vpc_id = module.vpc2.vpc_id
  vpc_id = module.vpc1.vpc_id
  peer_region = var.region
  auto_accept = true

  tags = {
    "Name" = "VPC peering connection between vpc1 and vpc2"
  }
  
}

resource "aws_route" "vpc1_to_vpc2" {
  count = length(module.vpc1.private_route_table_ids)
  route_table_id = module.vpc1.private_route_table_ids[count.index]
  destination_cidr_block = module.vpc2.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "vpc2_to_vpc1" {
  count = length(module.vpc2.private_route_table_ids)
  route_table_id = module.vpc2.private_route_table_ids[count.index]
  destination_cidr_block = module.vpc1.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}