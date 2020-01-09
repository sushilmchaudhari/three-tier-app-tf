output "ec2_details" {
  value = aws_instance.server
}

output "eip" {
  value = aws_eip.pub_ip_fixed
}
