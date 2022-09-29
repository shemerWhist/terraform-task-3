
# private security group vpc1
resource "aws_security_group" "private_group_vpc1" {
  name        = "${terraform.workspace}-private-group"
  description = "private security group"
  vpc_id      = var.vpc1_id

  tags = {
    "Name" = "private_group_vpc1"
  }
}

# rules
resource "aws_security_group_rule" "private-out_vpc1" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_group_vpc1.id
}
resource "aws_security_group_rule" "private-in-ssh_vpc1" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.vpc1-cidr-block, var.vpc2-cidr-block]
  security_group_id = aws_security_group.private_group_vpc1.id
}
resource "aws_security_group_rule" "private-in-ICMP_vpc1" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.vpc1-cidr-block, var.vpc2-cidr-block]
  security_group_id = aws_security_group.private_group_vpc1.id
}


# public security group vpc1
resource "aws_security_group" "public-group" {
  name        = "${terraform.workspace}-public-group"
  description = "public security group"
  vpc_id      = var.vpc1_id

  tags = {
    "Name" = "public_group_vpc1"
  }
}

# rules 
resource "aws_security_group_rule" "public-out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public-group.id
}
resource "aws_security_group_rule" "public-in-ssh" {
  type              = "ingress"
  description       = "ssh"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public-group.id
}
resource "aws_security_group_rule" "public-in-http" {
  type              = "ingress"
  description       = "http"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public-group.id
}
resource "aws_security_group_rule" "public-in-ICMP" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public-group.id
}
# resource "aws_security_group_rule" "public-in-vpn-access" {
#   type              = "ingress"
#   from_port         = 443
#   to_port           = 443
#   protocol          = "UDP"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.public-group.id
# }



# private security group vpc1
resource "aws_security_group" "private_group_vpc2" {
  name        = "${terraform.workspace}-private-group"
  description = "private security group"
  vpc_id      = var.vpc2_id

  tags = {
    "Name" = "private_group_vpc2"
  }
}

# rules
resource "aws_security_group_rule" "private-out_vpc2" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private_group_vpc2.id
}
resource "aws_security_group_rule" "private-in-ssh_vpc2" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.vpc1-cidr-block]
  security_group_id = aws_security_group.private_group_vpc2.id
}
resource "aws_security_group_rule" "private-in-ICMP_vpc2" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = [var.vpc1-cidr-block]
  security_group_id = aws_security_group.private_group_vpc2.id
}

# vpn security group
resource "aws_security_group" "vpn-group" {
  name        = "${terraform.workspace}-vpn-group"
  description = "vpn security group"
  vpc_id      = var.vpc1_id

  tags = {
    "Name" = "vpn-security-group"
  }
}

# rules 
resource "aws_security_group_rule" "out-vpn-access" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpn-group.id
}
resource "aws_security_group_rule" "in-vpn-access" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "UDP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.vpn-group.id
}