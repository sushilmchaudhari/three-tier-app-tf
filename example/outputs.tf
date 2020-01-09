output "mgt_static_public_ip_address" {
  value = module.mgt-ec2.eip[*].public_ip
}

output "app_server_list" {
  value = module.app-ec2.ec2_details[*].private_ip
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.main-alb.load_balancer.dns_name
}

# output "db_master_endpoint" {
#   description = "master RDS database endpoint"
#   value       = module.master_db.db_instance[*].address
# }
#
# output "db_replica_endpoint" {
#   description = "Replica RDS database endpoint"
#   value       = module.replica.db_instance[*].address
# }
#
# output "cw_notification_group" {
#   description = "CloudWatch Notification Topic/Group"
#   value       = aws_sns_topic.alarm.id
# }
