
locals {
  envi = terraform.workspace
  random_str = random_id.server.dec
}

resource "random_id" "server" {
  byte_length = 1
}

# Paramerter group for RDS

resource "aws_db_parameter_group" "pgroup" {

  count = var.create_parameter_group ? 1 : 0
  name = format("%s-%s-rds-paramerter-group-%s", var.name, local.envi, local.random_str)
  description = "Database parameter group for ${var.db_identifier} in ${local.envi} environment"
  family      = var.pgroup_family

  dynamic "parameter" {
    for_each = var.pgroup_parameters

    content {
      name = parameter.key
      value = parameter.value
    }
  }

  tags = merge(var.tags, {"Name" = format("%s-%s-rds-paramerter-group", var.name, local.envi)})

  lifecycle {
    create_before_destroy = true
  }
}

# Option group for RDS

resource "aws_db_option_group" "ogroup" {
  count = var.create_option_group ? 1 : 0

  name                     = format("%s-%s-rds-option-group-%s", var.name, local.envi, local.random_str)
  option_group_description = "Database option group for ${var.db_identifier} in ${local.envi} environment"
  engine_name              = var.ogroup_engine_name
  major_engine_version     = var.ogroup_major_engine_version

  dynamic "option" {
    for_each = var.ogroup_options
    content {
      option_name = option.key

      dynamic "option_settings" {
        for_each = option.value
        content {
          name = option_settings.key
          value = option_settings.value
        }
      }
    }
  }

  tags = merge(var.tags, {"Name" = format("%s-%s-rds-paramerter-group", var.name, local.envi)})

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      name,
    ]
  }
}

# RDS INSTANCE

resource "aws_db_instance" "db" {
  count = var.create_master || var.create_replica ? 1 : 0

  identifier        = format("%s-%s-database-%s", var.name, local.envi, var.db_identifier)

  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  storage_type      = var.db_storage_type

  # DB Encryption
  storage_encrypted = var.db_storage_encrypted
  kms_key_id        = var.kms_key_id

  # Database Details
  name              = var.db_name
  username          = var.db_username
  password          = var.db_password
  port              = var.db_port


  # Replication for Replica instances. This should be the master instance id
  replicate_source_db = var.replicate_source_db

  vpc_security_group_ids = var.db_vpc_security_group_ids
  db_subnet_group_name   = var.db_subnet_group_name
  parameter_group_name   = aws_db_parameter_group.pgroup[0].id
  option_group_name      = aws_db_option_group.ogroup[0].id
  # option_group_name      = aws_db_option_group.ogroup[1].name

  availability_zone   = var.az_ids
  multi_az            = var.db_multi_az
  publicly_accessible = var.db_publicly_accessible

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately

  maintenance_window          = var.maintenance_window

  skip_final_snapshot         = var.skip_final_snapshot
  final_snapshot_identifier   = var.final_snapshot_identifier

  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  deletion_protection = var.deletion_protection

  snapshot_identifier = var.snapshot_identifier

  tags = merge(var.tags, {"Name" = format("%s-%s-db", var.db_identifier, local.envi)})

  lifecycle {
    ignore_changes = [
      option_group_name,
    ]
  }
}
