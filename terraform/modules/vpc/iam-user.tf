
resource "aws_iam_saml_provider" "saml-provider" {
    name = "test-vpn-provider"
    saml_metadata_document = file("/mnt/c/Users/sheme/Desktop/Terraform task 3/terraform/modules/vpc/saml-metadata.xml")
  
    tags = {
        "Name" = "test-saml-provider"
    }
}

# resource "aws-sso-scim_user" "example" {
#   user_name    = "shemer@whist.co.il"
#   given_name   = "John"
#   family_name  = "Doe"
#   display_name = "John Doe"
# }