
terraform {
  backend "s3" {
    bucket         = "shemer-terraform-task3"
    key            = "task/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "shemer-terraform-task3-dbtable"
  }
}