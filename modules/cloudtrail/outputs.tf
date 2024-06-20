output "bucket_name" {
value = aws_s3_bucket.for_cloudtrail.bucket
description = "Name of the S3 Bucket"
}
output "cloudtrail_name" {
    value = aws_cloudtrail.logging.name
  description = "Name of the CloudTrail"
}