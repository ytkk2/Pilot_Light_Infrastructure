output "security_group_id" {
  value       = aws_security_group.db_sg.id
  description = "The ID of the VPC"
}
output "security_db_sg_id" {
  value = aws_security_group.db_sg.id
}
output "db_sg_id" {
  value       = aws_security_group.db_sg.id
  description = "Security group ID for the database"
}
output "ec2_sg_id" {
  value       = aws_security_group.ec2_sg.id
  description = "Security group ID for the ec2"
}
output "alb_sg_id" {
  value       = aws_security_group.alb_sg.id
  description = "Security group ID for the alb"
}
