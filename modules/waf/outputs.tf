output "waf_acl_id" {
  value       = aws_wafv2_web_acl.web_acl.id
  description = "ID of the WAF Web ACL."
}

output "waf_acl_arn" {
  value       = aws_wafv2_web_acl.web_acl.arn
  description = "ARN of the WAF Web ACL."
}
