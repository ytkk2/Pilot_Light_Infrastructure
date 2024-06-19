output "mariadb_endpoint" {
  value       = aws_db_instance.mariadb.endpoint
  description = "The endpoint of the MariaDB instance"
}