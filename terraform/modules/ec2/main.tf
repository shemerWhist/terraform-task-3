
# vpc1 ec2 private instances
module "ec2_instance_private_vpc1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(var.vpc1_private_subnets)

  name = "ec2_instance_private_vpc1_${each.key}"

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key
  vpc_security_group_ids = [var.private_vpc1_sg_id]
  subnet_id              = each.key

  tags = {
    Terraform   = "true"
    Name        = "ec2_instance_private_vpc1_${each.key}"
    Environment = "${terraform.workspace}"
  }

}

# vpc2 ec2 private instances
module "ec2_instance_private_vpc2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(var.vpc2_private_subnets)

  name = "ec2_instance_private_vpc2_${each.key}"

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key
  vpc_security_group_ids = [var.private_vpc2_sg_id]
  subnet_id              = each.key

  tags = {
    Terraform   = "true"
    Name        = "ec2_instance_private_vpc2_${each.key}"
    Environment = "${terraform.workspace}"
  }

}

# vpc1 ec2 public instances
module "ec2_instance_public_vpc1" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(var.vpc1_public_subnets)

  name = "ec2_instance_public_vpc1_${each.key}"

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key
  vpc_security_group_ids = [var.public_vpc1_sg_id]
  subnet_id              = each.key

  tags = {
    Terraform   = "true"
    Name        = "ec2_instance_public_vpc1_${each.key}"
    Environment = "${terraform.workspace}"
  }

}
