variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the RDS instance"
}

variable "security_group_id" {
  description = "The ID of the security group for the RDS instance"
  type        = string
}
# variable "db_username" {
#   description = "The database admin username"
#   type        = string
#   default     = "admin"
# }
variable "secret_name" {
  description = "The name of the secret in AWS Secrets Manager"
  type        = string
  default     = "rds-db-password"
}