output "private2_route_tables_ids" {
  value = module.vpc2.private_route_table_ids
}

output "private1_route_tables_ids" {
  value = module.vpc1.private_route_table_ids
}