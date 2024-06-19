output "aws_web_instance_ids" {
  #   value       = aws_instance.web_instance[*].id
  value       = [for instance in aws_instance.web_instance : instance.id]
  description = "IDs of the created EC2 instances"
}
# output "aws_instance_ids" {
#   value = [for instance in aws_instance.web_instance : instance.id]
# }
