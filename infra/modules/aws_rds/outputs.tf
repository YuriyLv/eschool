output "db_instance_address" {
  value = module.db.db_instance_address
}
output "db_database_name" {
  value = module.db.db_instance_name
}
output "db_instance_username" {
  sensitive = true
  value     = module.db.db_instance_username
}
output "db_instance_password" {
  sensitive = true
  value     = module.db.db_instance_password
}


