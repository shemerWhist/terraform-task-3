output "private_vpc1_sg_id" {
  value = aws_security_group.private_group_vpc1.id
}

output "private_vpc2_sg_id" {
  value = aws_security_group.private_group_vpc2.id
}

output "public_vpc1_sg_id" {
  value = aws_security_group.public-group.id
}

output "vpn_group_sg_id" {
  value = aws_security_group.vpn-group.id
}