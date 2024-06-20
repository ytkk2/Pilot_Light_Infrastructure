variable "domain_name" {
  description = "The domain name to use for the Route 53 hosted zone"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "The Zone ID of the ALB"
  type        = string
}

variable "subdomain_name" {
  description = "The subdomain name to use for the Route 53 record"
  type        = string
  default     = "www"
}

variable "record_type" {
  description = "The DNS record type"
  type        = string
  default     = "A"
}