
data "aws_acm_certificate" "server" {
  domain = "server"
}

data "aws_acm_certificate" "client" {
  domain = "client1.domain.tld"
}

## need to create certificates and import them to AWS ACM using terraform 
# data "aws_acm_certificate" "server" {
#   domain = "server"
# }
# data "aws_acm_certificate" "client" {
#   domain = "client1.domain.tld"
# }

resource "aws_ec2_client_vpn_authorization_rule" "vpn_auth_rule" {
  client_vpn_endpoint_id   = module.vpn.ec2_client_vpn_endpoint_id
  target_network_cidr      = var.vpc1_cidr_block
  authorize_all_groups     = true
}

module "vpn" {
  source                     = "fivexl/client-vpn-endpoint/aws"
  version = "4.0.0"
  endpoint_name              = "shemer_client_vpn_endpoint"
  endpoint_client_cidr_block = "20.10.0.0/16"
  endpoint_subnets           = [module.vpc1.public_subnets[0], module.vpc1.public_subnets[1]] 
  endpoint_vpc_id            = module.vpc1.vpc_id
  certificate_arn            = data.aws_acm_certificate.server.arn
  saml_provider_arn          = aws_iam_saml_provider.saml-provider.arn

  authorization_rules = {}

  cloudwatch_log_group_name_prefix = aws_cloudwatch_log_group.vpn_connection.name_prefix
}


resource "aws_cloudwatch_log_group" "vpn_connection" {
  name_prefix = "vpn_endpoint_connection-"

  tags = {
    Environment = "${terraform.workspace}"
  }
}