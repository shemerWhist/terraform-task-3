output "private2_route_tables_ids" {
  value = module.vpc2.private_route_table_ids
}

output "private1_route_tables_ids" {
  value = module.vpc1.private_route_table_ids
}

output "vpc1_private_subnets" {
  value = module.vpc1.private_subnets
  
}

output "vpc1_public_subnets" {
    value = module.vpc1.public_subnets
}

output "vpc2_private_subnets" {
    value = module.vpc2.private_subnets
}

output "vpc1" {
  value = module.vpc1
}

output "vpc2" {
  value = module.vpc2 
}