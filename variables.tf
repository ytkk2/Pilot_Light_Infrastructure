variable "region" {
  default = "ap-northeast-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "web_subnets" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "db_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "domain_name" {
  description = "The domain name for the Route 53 zone"
  type        = string
  default     = "terraformwordpress.com"
}

variable "bucket_name" {
  description = "The name of the S3 bucket for CloudTrail logs"
  type        = string
  default     = "s3-bucket-for-cloudtrail"
}

variable "cloudtrail_name" {
  description = "The name of the CloudTrail"
  type        = string
  default     = "cloudtrail-for-logging"
}

variable "instance_count" {
  description = "The number of EC2 instances"
  type        = number
  default     = 2
}

variable "rate_limit" {
  description = "The rate limit for WAF"
  type        = number
  default     = 100
}