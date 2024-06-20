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

variable "waf_name" {
  description = "The name of the WAF ACL"
  type        = string
  default     = "rate-base-web-acl"
}

variable "rate_limit_rule_name" {
  description = "The name of the rate limit rule"
  type        = string
  default     = "rate-limit-rule"
}

variable "aggregate_key_type" {
  description = "The key type for aggregating requests"
  type        = string
  default     = "IP"
}

variable "search_string" {
  description = "The search string for the byte match statement"
  type        = string
  default     = "/"
}

variable "positional_constraint" {
  description = "The positional constraint for the byte match statement"
  type        = string
  default     = "CONTAINS"
}

variable "text_transformation_priority" {
  description = "The priority of the text transformation"
  type        = number
  default     = 0
}

variable "text_transformation_type" {
  description = "The type of the text transformation"
  type        = string
  default     = "NONE"
}

variable "waf_tags" {
  description = "Tags for the WAF ACL"
  type        = map(string)
  default     = {
    Name = "rate-base-web-acl"
  }
}