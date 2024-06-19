output "mariadb_endpoint" {
  value       = module.rds.mariadb_endpoint
  description = "The endpoint of the MariaDB instance"
}