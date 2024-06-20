variable "alb_arn" {
  description = "The ARN of the Application Load Balancer to associate the WAF ACL with."
  type        = string
}

variable "rate_limit" {
  description = <<-EOT
    "The maximum number of requests allowed in a 5-minute period 
    (10 requests per minute)"
  EOT
  type        = number
}

