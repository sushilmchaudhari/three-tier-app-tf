output "mgt_sg" {
  value = aws_security_group.mgt
}

output "app_sg" {
  value = aws_security_group.app
}

output "rds_sg" {
  value = aws_security_group.rds
}

output "lb_sg" {
  value = aws_security_group.lb
}
