output "vpc" {
  value = aws_vpc.this
}

output "mgt_subnets" {
  value = aws_subnet.public
}

output "app_subnets" {
  value = aws_subnet.app
}

output "lb_subnets" {
  value = aws_subnet.lb
}

output "rds_subnets" {
  value = aws_subnet.rds
}

output "rds_subnet_group" {
  value = aws_db_subnet_group.rds
}

# Static values (arguments)
output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = var.azs
}
