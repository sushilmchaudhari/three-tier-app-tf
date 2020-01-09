# module "master_db" {
#   source = "../modules/rds/"
#
#   create_master = true
#
#   name = var.name
#
#   db_identifier = var.master_db_identifier
#
#   # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
#   db_engine            = "mysql"
#   db_engine_version    = var.mysql_version
#   db_instance_class    = var.mysql_instance_type
#   db_allocated_storage = var.mysql_storage
#   db_storage_encrypted = false
#
#   db_name     = var.database_name
#   db_username = var.database_user
#   db_password = var.database_passwd
#   db_port     = var.database_port
#
#   db_vpc_security_group_ids = module.main-sg.rds_sg[*].id
#   db_subnet_group_name      = module.main-vpc.rds_subnet_group[0].id
#
#   maintenance_window = var.maintenance_window
#   backup_window      = var.backup_window
#
#   auto_minor_version_upgrade = var.auto_minor_version_upgrade
#
#   db_multi_az = true
#
#   # Backups are required in order to create a replica
#   backup_retention_period = var.master_backup_retention_period
#
#   tags = merge(var.tags, {"Environment" = terraform.workspace})
#
#   enabled_cloudwatch_logs_exports = ["audit", "general"]
#
#   # DB parameter group
#   create_parameter_group = true
#   pgroup_family          = "mysql5.6"
#   pgroup_parameters      = var.db_parameters
#
#
#   # DB option group
#   create_option_group         = true
#   ogroup_major_engine_version = "5.6"
#
#   # Snapshot name upon DB deletion
#   skip_final_snapshot       = true
#   final_snapshot_identifier = var.master_db_identifier
#
#   # Database Deletion Protection
#   deletion_protection = false
# }
#
# module "replica" {
#   source = "../modules/rds/"
#
#   create_replica = true
#
#   name = var.name
#
#   db_identifier = var.replica_db_identifier
#
#   # Source database. For cross-region use this_db_instance_arn
#   replicate_source_db = module.master_db.db_instance[0].id
#
#   # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
#   db_engine            = "mysql"
#   db_engine_version    = var.mysql_version
#   db_instance_class    = var.mysql_instance_type
#   db_allocated_storage = var.mysql_storage
#   db_storage_encrypted = false
#
#   db_username = ""
#   db_password = ""
#   db_port     = var.database_port
#
#   db_vpc_security_group_ids = module.main-sg.rds_sg[*].id
#
#   auto_minor_version_upgrade = false
#
#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"
#
#   # disable backups to create DB faster
#   backup_retention_period = 0
#
#   tags = merge(var.tags, {"Environment" = terraform.workspace})
#
#   enabled_cloudwatch_logs_exports = ["audit", "general"]
#
#   # DB parameter group
#   create_parameter_group = true
#   pgroup_family          = "mysql${replace(var.mysql_version, "/\\.[\\d]+$/", "")}"
#
#   # DB option group
#   create_option_group         = false
#   ogroup_major_engine_version = replace(var.mysql_version, "/\\.[\\d]+$/", "")
#
#   # Snapshot name upon DB deletion
#   skip_final_snapshot       = true
#   final_snapshot_identifier = "${var.replica_db_identifier}-final" # Used when skip_final_snapshot = false.
#
#   # Database Deletion Protection
#   deletion_protection = false
# }
