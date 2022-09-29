
variable "ami" {
  type = string
}

variable "vpc2_private_subnets" {
  type = list(string)
}

variable "instance_type" {
  type = string
}

variable "key" {
  type = string
}

variable "private_vpc2_sg_id" {
  type = string
}

variable "cluster_name" {
  type = string
}
