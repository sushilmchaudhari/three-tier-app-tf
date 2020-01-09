# resource "aws_sns_topic" "alarm" {
#   name = format("%s-%s-cw-alarm-topic", var.name, terraform.workspace)
# }
#
# ## SERVER INSTANCES
#
# resource "aws_cloudwatch_metric_alarm" "cpu-utilization" {
#   count = var.enable_cloudwatch ? var.app_instance_count + var.worker_instance_count : 0
#   alarm_name = "cpu-utilization-${element(concat(module.app-ec2.ec2_details[*].id, module.worker-ec2.ec2_details[*].id), count.index)}"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "85"
#   alarm_description   = "This metric monitors ec2 cpu utilization"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     InstanceId = element(
#       concat(
#         module.app-ec2.ec2_details[*].id,
#         module.worker-ec2.ec2_details[*].id,
#       ),
#       count.index,
#     )
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "memory-utilization" {
#   count = var.enable_cloudwatch ? var.app_instance_count + var.worker_instance_count : 0
#   alarm_name = "memory-utilization-${element(
#     concat(
#       module.app-ec2.ec2_details[*].id,
#       module.worker-ec2.ec2_details[*].id,
#     ),
#     count.index,
#   )}"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "MemoryUtilization"
#   namespace           = "CWAgent"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = var.ec2_memory_utilization_threshold
#   alarm_description   = "This metric monitors ec2 memory utilization"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     InstanceId = element(
#       concat(
#         module.app-ec2.ec2_details[*].id,
#         module.worker-ec2.ec2_details[*].id,
#       ),
#       count.index,
#     )
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "instance-health-check" {
#   count = var.enable_cloudwatch ? var.app_instance_count + var.worker_instance_count : 0
#   alarm_name = "instance-health-check-${element(
#     concat(
#       module.app-ec2.ec2_details[*].id,
#       module.worker-ec2.ec2_details[*].id,
#     ),
#     count.index,
#   )}"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "StatusCheckFailed"
#   namespace           = "AWS/EC2"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "1"
#   alarm_description   = "This metric monitors ec2 health status"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     InstanceId = element(
#       concat(
#         module.app-ec2.ec2_details[*].id,
#         module.worker-ec2.ec2_details[*].id,
#       ),
#       count.index,
#     )
#   }
# }
#
# # Root disk utilization
#
# resource "aws_cloudwatch_metric_alarm" "Disk-utilization-root" {
#   count = var.enable_cloudwatch ? var.app_instance_count + var.worker_instance_count : 0
#   alarm_name = "Disk-utilization-root-${element(
#     concat(
#       module.app-ec2.ec2_details[*].id,
#       module.worker-ec2.ec2_details[*].id,
#     ),
#     count.index,
#   )}"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "DiskSpaceUtilization"
#   namespace           = "CWAgent"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "85"
#   alarm_description   = "This metric monitors ec2 Disk utilization"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     path   = "/"
#     device = var.ec2_root_device_name
#     fstype = "ext4"
#     InstanceId = element(
#       concat(
#         module.app-ec2.ec2_details[*].id,
#         module.worker-ec2.ec2_details[*].id,
#       ),
#       count.index,
#     )
#   }
# }
#
# # Data Disk utilization
#
# resource "aws_cloudwatch_metric_alarm" "Disk-utilization-data" {
#   count = var.enable_cloudwatch && var.required_data_partition ? var.app_instance_count + var.worker_instance_count : 0
#   alarm_name = "Disk-utilization-data-${element(
#     concat(
#       module.app-ec2.ec2_details[*].id,
#       module.worker-ec2.ec2_details[*].id,
#     ),
#     count.index,
#   )}"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "DiskSpaceUtilization"
#   namespace           = "CWAgent"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "85"
#   alarm_description   = "This metric monitors ec2 Disk utilization"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     path   = "/data"
#     device = "xvdn"
#     fstype = "ext4"
#     InstanceId = element(
#       concat(
#         module.app-ec2.ec2_details[*].id,
#         module.worker-ec2.ec2_details[*].id,
#       ),
#       count.index,
#     )
#   }
# }
#
# ## Master RDS Monitoring
# # This is disabled since RDS doesn't have cpu burst credits
# resource "aws_cloudwatch_metric_alarm" "burst_balance_too_low" {
#   count               = 0
#   alarm_name          = "burst_balance_too_low-${var.master_db_identifier}"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "BurstBalance"
#   namespace           = "AWS/RDS"
#   period              = "600"
#   statistic           = "Average"
#   threshold           = var.rds_burst_balance_threshold
#   alarm_description   = "Average database storage burst balance over last 10 minutes too low, expect a significant performance drop soon"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     DBInstanceIdentifier = element(module.master_db.db_instance[*].id, 0)
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "cpu_utilization_too_high" {
#   count               = var.enable_cloudwatch ? 1 : 0
#   alarm_name          = "cpu_utilization_too_high-${var.master_db_identifier}"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/RDS"
#   period              = "600"
#   statistic           = "Average"
#   threshold           = "80"
#   alarm_description   = "Average database CPU utilization over last 10 minutes too high"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     DBInstanceIdentifier = element(module.master_db.db_instance[*].id, 0)
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "cpu_credit_balance_too_low" {
#   count               = var.enable_cloudwatch ? 1 : 0
#   alarm_name          = "cpu_credit_balance_too_low-${var.master_db_identifier}"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "CPUCreditBalance"
#   namespace           = "AWS/RDS"
#   period              = "600"
#   statistic           = "Average"
#   threshold           = "20"
#   alarm_description   = "Average database CPU credit balance over last 10 minutes too low, expect a significant performance drop soon"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     DBInstanceIdentifier = element(module.master_db.db_instance[*].id, 0)
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "disk_queue_depth_too_high" {
#   count               = var.enable_cloudwatch ? 1 : 0
#   alarm_name          = "disk_queue_depth_too_high-${var.master_db_identifier}"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "DiskQueueDepth"
#   namespace           = "AWS/RDS"
#   period              = "600"
#   statistic           = "Average"
#   threshold           = "64"
#   alarm_description   = "Average database disk queue depth over last 10 minutes too high, performance may suffer"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     DBInstanceIdentifier = element(module.master_db.db_instance[*].id, 0)
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "freeable_memory_too_low" {
#   count               = var.enable_cloudwatch ? 1 : 0
#   alarm_name          = "freeable_memory_too_low-${var.master_db_identifier}"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "FreeableMemory"
#   namespace           = "AWS/RDS"
#   period              = "600"
#   statistic           = "Average"
#   threshold           = "100000000"
#   alarm_description   = "Average database freeable memory over last 10 minutes too low, performance may suffer"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     DBInstanceIdentifier = element(module.master_db.db_instance[*].id, 0)
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "free_storage_space_too_low" {
#   count               = var.enable_cloudwatch ? 1 : 0
#   alarm_name          = "free_storage_space_threshold-${var.master_db_identifier}"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "FreeStorageSpace"
#   namespace           = "AWS/RDS"
#   period              = "600"
#   statistic           = "Average"
#   threshold           = var.rds_free_storage_space_threshold
#   alarm_description   = "Average database free storage space over last 10 minutes too low"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     DBInstanceIdentifier = element(module.master_db.db_instance[*].id, 0)
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "swap_usage_too_high" {
#   count               = var.enable_cloudwatch ? 1 : 0
#   alarm_name          = "swap_usage_too_high-${var.master_db_identifier}"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "SwapUsage"
#   namespace           = "AWS/RDS"
#   period              = "600"
#   statistic           = "Average"
#   threshold           = "256000000"
#   alarm_description   = "Average database swap usage over last 10 minutes too high, performance may suffer"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     DBInstanceIdentifier = element(module.master_db.db_instance[*].id, 0)
#   }
# }
#
# ## ElastiCache for Redis
#
# resource "aws_cloudwatch_metric_alarm" "redis_cache_cpu_util" {
#   count = var.enable_cloudwatch ? var.redis_cache_node_count : 0
#   alarm_name = "cpu-utilization-${element(
#     flatten(module.ec-redis-cache.redis_details[*].member_clusters),
#     count.index,
#   )}"
#   alarm_description   = "Redis Cache cluster CPU utilization"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ElastiCache"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "85"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     CacheClusterId = element(
#       flatten(module.ec-redis-cache.redis_details[*].member_clusters),
#       count.index,
#     )
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "redis_jobs_cpu_util" {
#   count = var.enable_cloudwatch ? var.redis_jobs_node_count : 0
#   alarm_name = "cpu-utilization-${element(
#     flatten(module.ec-redis-jobs.redis_details[*].member_clusters),
#     count.index,
#   )}"
#   alarm_description   = "Redis Jobs cluster CPU utilization"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ElastiCache"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "85"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     CacheClusterId = element(
#       flatten(module.ec-redis-jobs.redis_details[*].member_clusters),
#       count.index,
#     )
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "redis_cache_swap_util" {
#   count = var.enable_cloudwatch ? var.redis_cache_node_count : 0
#   alarm_name = "swap-utilization-${element(
#     flatten(module.ec-redis-cache.redis_details[*].member_clusters),
#     count.index,
#   )}"
#   alarm_description   = "Redis Cache Node Swap Usage"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "SwapUsage"
#   namespace           = "AWS/ElastiCache"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "150000000"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     CacheClusterId = element(
#       flatten(module.ec-redis-cache.redis_details[*].member_clusters),
#       count.index,
#     )
#   }
# }
#
# resource "aws_cloudwatch_metric_alarm" "redis_jobs_swap_util" {
#   count = var.enable_cloudwatch ? var.redis_jobs_node_count : 0
#   alarm_name = "swap-utilization-${element(
#     flatten(module.ec-redis-jobs.redis_details[*].member_clusters),
#     count.index,
#   )}"
#   alarm_description   = "Redis Jobs Node Swap Usage"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = "2"
#   metric_name         = "SwapUsage"
#   namespace           = "AWS/ElastiCache"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "150000000"
#   alarm_actions       = [aws_sns_topic.alarm.arn]
#
#   dimensions = {
#     CacheClusterId = element(
#       flatten(module.ec-redis-jobs.redis_details[*].member_clusters),
#       count.index,
#     )
#   }
# }
