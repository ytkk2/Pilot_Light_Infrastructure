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

variable "tg_port" {
  description = "The port for the target group"
  type        = number
  default     = 80
}

variable "tg_protocol" {
  description = "The protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "The health check path"
  type        = string
  default     = "/"
}

variable "health_check_interval" {
  description = "The health check interval"
  type        = number
  default     = 30
}

variable "health_check_timeout" {
  description = "The health check timeout"
  type        = number
  default     = 5
}

variable "healthy_threshold" {
  description = "The healthy threshold for health checks"
  type        = number
  default     = 2
}

variable "unhealthy_threshold" {
  description = "The unhealthy threshold for health checks"
  type        = number
  default     = 2
}

variable "matcher" {
  description = "The health check matcher"
  type        = string
  default     = "200-299"
}

variable "listener_port" {
  description = "The listener port"
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "The listener protocol"
  type        = string
  default     = "HTTP"
}
