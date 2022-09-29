region = "eu-central-1"

# vpc1
vpc1_cidr_block   = "10.10.0.0/16"
pub_vpc1_sub_cidr = ["10.10.1.0/24", "10.10.2.0/24"]
prv_vpc1_sub_cidr = ["10.10.3.0/24", "10.10.4.0/24"]


# vpc2
vpc2_cidr_block   = "10.11.0.0/16"
prv_vpc2_sub_cidr = ["10.11.1.0/24", "10.11.2.0/24"]

vpc_peer_owner_id = "930354804502"

vpc_peering_namespace = "shemer-task3-peering"

# ec2
type = "t2.micro"
key = "key-for-task"
 
