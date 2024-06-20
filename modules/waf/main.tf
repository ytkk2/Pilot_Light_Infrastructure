resource "aws_wafv2_web_acl" "web_acl" {
  name        = var.waf_name
  description = "Web ACL to block IPs with more than 10 requests per minute"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = var.rate_limit_rule_name
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = var.rate_limit
        aggregate_key_type = var.aggregate_key_type

        scope_down_statement {
          byte_match_statement {
            search_string = var.search_string
            positional_constraint = var.positional_constraint

            field_to_match {
              uri_path {}
            }

            text_transformation {
              priority = var.text_transformation_priority
              type     = var.text_transformation_type
            }
          }
        }
      }
    }
    
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = var.rate_limit_rule_name
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "web-acl"
    sampled_requests_enabled   = true
  }

  tags = var.waf_tags
}

resource "aws_wafv2_web_acl_association" "example" {
  resource_arn = var.alb_arn
  web_acl_arn  = aws_wafv2_web_acl.web_acl.arn
}
