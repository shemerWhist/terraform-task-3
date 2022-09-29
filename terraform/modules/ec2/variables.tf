variable "instance_type" {
    type = string
}

variable "key" {
    type = string
}

variable "private_vpc1_sg_id" {
    type = string
}

variable "private_vpc2_sg_id" {
    type = string
}

variable "public_vpc1_sg_id" {
    type = string
}

variable "vpc1_private_subnets" {
    type = list(string)
}

variable "vpc1_public_subnets" {
    type = list(string)
}

variable "vpc2_private_subnets" {
    type = list(string)
}