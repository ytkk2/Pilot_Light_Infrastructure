variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where security resources will be created."
}
variable "security_db_sg_id" {
  type        = string
  description = "ID of the security group to be used with the RDS instance"
}

variable "ingress_http_port" {
  description = "The HTTP port for ingress rules"
  type        = number
  default     = 80
}

variable "egress_all_ports" {
  description = "The ports for egress rules"
  type        = number
  default     = 0
}

variable "ingress_db_port" {
  description = "The database port for ingress rules"
  type        = number
  default     = 3306
}

variable "cidr_blocks" {
  description = "The CIDR blocks for ingress and egress rules"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}