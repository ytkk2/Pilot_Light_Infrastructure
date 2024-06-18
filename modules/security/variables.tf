variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where security resources will be created."
}
variable "security_db_sg_id" {
  type        = string
  description = "ID of the security group to be used with the RDS instance"
}