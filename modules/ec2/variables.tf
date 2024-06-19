variable "instance_count" {
  type        = number
  description = "The number of instances to launch."
}
variable "subnets" {
  description = "List of subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group for the ec2 instance"
  type        = string
}
