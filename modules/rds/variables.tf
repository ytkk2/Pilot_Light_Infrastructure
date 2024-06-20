variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the RDS instance"
}

variable "security_group_id" {
  description = "The ID of the security group for the RDS instance"
  type        = string
}

variable "secret_name" {
  description = "The name of the secret in AWS Secrets Manager"
  type        = string
  default     = "rds-db-password"
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string
  default     = "10.6.14"
}

variable "instance_class" {
  description = "The instance class of the database"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "The allocated storage size for the database (in GB)"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "The storage type for the database"
  type        = string
  default     = "gp2"
}