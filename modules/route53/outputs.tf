output "zone_id" {
  value       = aws_route53_zone.main.zone_id
  description = "The Zone ID of the Route 53 hosted zone"
}

output "record_name" {
  value       = aws_route53_record.www.fqdn
  description = "The fully qualified domain name of the record"
}
