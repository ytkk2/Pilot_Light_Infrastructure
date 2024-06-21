output "mariadb_endpoint" {
  value       = module.rds.mariadb_endpoint
  description = "The endpoint of the MariaDB instance"
}

output "s3_bucket_name" {
  value = module.cloudtrail.bucket_name
  description = "Name of the s3 bucket for cloudtrail"
}