variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where security resources will be created."
}
variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the alb"
}
variable "security_group_id" {
  type        = string
  description = "ID of the security group to be used with the alb"
}
variable "aws_instance_ids" {
  type = list(string)
}
variable "instance_count" {
  type        = number
  description = "The number of EC2 instances."
}
