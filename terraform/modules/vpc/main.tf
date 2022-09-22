
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

  # create_igw = true

  tags = {
    Name        = "vpc2"
    Terraform   = "true"
    Environment = "${terraform.workspace}"
    Facing      = "private"
  }
}
