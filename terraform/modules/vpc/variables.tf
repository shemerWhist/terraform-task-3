# vpc1
variable "vpc1_cidr_block" {
  type = string
}

variable "prv_vpc1_sub_cidr" {
  type = list(string)
}

variable "pub_vpc1_sub_cidr" {
  type = list(string)
}

# vpc2
variable "vpc2_cidr_block" {
  type = string
}

variable "prv_vpc2_sub_cidr" {
  type = list(string)
}

variable "vpc_peer_owner_id" {
  type = string
}

variable "vpc_peering_namespace" {
  type = string
}

variable "region" {
  type = string
}

variable "vpn_group_sg_id" {
  type = string
}
