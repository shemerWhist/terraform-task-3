variable "region" {
  type        = string
  description = "region"
}

variable "vpc1_cidr_block" {
  type = string
}

variable "vpc2_cidr_block" {
  type = string
}

variable "prv_vpc2_sub_cidr" {
  type = list(string)
}

variable "pub_vpc1_sub_cidr" {
  type = list(string)
}

variable "prv_vpc1_sub_cidr" {
  type = list(string)
}

variable "vpc_peer_owner_id" {
  type = string
}

variable "vpc_peering_namespace" {
  type = string
}

variable "type" {
    type = string
}

variable "key" {
    type = string
}

# variable "" {
  
# }