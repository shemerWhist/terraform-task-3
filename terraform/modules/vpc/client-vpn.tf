
data "aws_acm_certificate" "server" {
  domain = "server"
}

data "aws_acm_certificate" "client" {
  domain = "client1.domain.tld"
}

resource "aws_ec2_client_vpn_endpoint" "vpn_endpint" {
    description = "client_vpn_endpoint"
    server_certificate_arn = data.aws_acm_certificate.server.arn
    client_cidr_block = "20.10.0.0/16"
    vpc_id = module.vpc1.vpc_id
    split_tunnel = true
    security_group_ids = [ var.vpn_group_sg_id ]
    # client_cidr_block = var.vpc1_cidr_block

    authentication_options {
        type = "certificate-authentication"
        root_certificate_chain_arn = data.aws_acm_certificate.client.arn
      
    }

    connection_log_options {
      enabled = true
      cloudwatch_log_group = aws_cloudwatch_log_group.vpn_connection.name
    }
}

resource "aws_ec2_client_vpn_network_association" "public_subnet_vpn_association" {
    count = length(module.vpc1.public_subnets)
    client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn_endpint.id
    subnet_id = module.vpc1.public_subnets[count.index]
}

resource "aws_ec2_client_vpn_authorization_rule" "vpn_auth_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn_endpint.id
  target_network_cidr = var.vpc1_cidr_block
  authorize_all_groups = true
}

resource "aws_cloudwatch_log_group" "vpn_connection" {
  name = "vpn_endpoint_connection"

  tags ={
    Environment = "${terraform.workspace}"
  }
}