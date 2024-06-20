output "vpc_id" {
  value       = aws_vpc.vpc01.id
  description = "The ID of the VPC"
}
output "private_subnet_db_ids" {
  value       = [for subnet in aws_subnet.private_subnet_db : subnet.id]
  description = "List of IDs of private DB subnets"
}
output "public_route_table_name" {
  value       = aws_route_table.public_route_table.tags["Name"]
  description = "The name of the public route table"
}
output "private_subnet_web_ids" {
  value       = [for subnet in aws_subnet.private_subnet_web : subnet.id]
  description = "List of IDs of private web subnets"
}
output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnet : subnet.id]
}
