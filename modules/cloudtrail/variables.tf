variable "bucket_name" {
  description = "The base name of the S3 bucket to store CloudTrail logs"
  type        = string
  default     = "s3-bucket-for-cloudtrail"
}

variable "cloudtrail_name" {
  description = "The name of the CloudTrail"
  type        = string
  default     = "cloudtrail-for-logging"
}