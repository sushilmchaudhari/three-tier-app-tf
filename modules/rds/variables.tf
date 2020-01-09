variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

# Parameter Group variables

variable "create_parameter_group" {
  description = "Create parameter group for RDS"
  default = "false"
}

variable "pgroup_family" {
  description = "The family of the DB parameter group"
}

variable "pgroup_parameters" {
  description = "A map of DB parameter options to apply For eg: pgroup_parameters = { character_set_server = utf8 }"
  type = map
  default     = {}
}


# Option Group variables

variable "create_option_group" {
  description = "Create parameter group for RDS"
  default = "false"
}

variable "ogroup_engine_name" {
  description = "Specifies the name of the engine that this option group should be associated with"
  default = "mysql"
}

variable "ogroup_major_engine_version" {
  description = "Specifies the major version of the engine that this option group should be associated with"
}

variable "ogroup_options" {
  type        = map
  description = "A map of Options to apply For eg: ogroup_options = { OPTON_NAME = { option_settings_name = option_settings_value, .. , ..} }"
  default     = {}
}


# DB INSTANCE VARIABLES

variable "create_master" {
  description = "Whether to create this resource or not?"
  default     = true
}

variable "create_replica" {
  description = "Whether to create this resource or not?"
  default     = false
}


variable "db_identifier" {
  description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
}

variable "db_allocated_storage" {
  description = "The allocated storage in gigabytes"
}

variable "db_storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  default     = "gp2"
}

variable "db_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  default     = false
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used"
  default     = ""
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate."
  default     = ""
}

variable "snapshot_identifier" {
  description = "Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05."
  default     = ""
}

variable "db_engine" {
  description = "The database engine to use"
}

variable "db_engine_version" {
  description = "The engine version to use"
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
}

variable "db_name" {
  description = "The DB name to create. If omitted, no database is created initially"
  default     = ""
}

variable "db_username" {
  description = "Username for the master DB user"
}

variable "db_password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file"
}

variable "db_port" {
  description = "The port on which the DB accepts connections"
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted."
  default     = ""
}

variable "db_vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  default     = []
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC"
  default     = ""
}

variable "az_ids" {
  description = "The Availability Zone of the RDS instance"
  default     = ""
}

variable "db_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

variable "db_publicly_accessible" {
  description = "Bool to control if instance is publicly accessible"
  default     = false
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default = "Mon:00:00-Mon:03:00"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier"
  default     = true
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  default     = 0
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  default = "00:01-00:03"
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace, postgresql (PostgreSQL), upgrade (PostgreSQL)."
  default     = []
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true."
  default     = false
}
