# Default Options

variable "name" {
  description = "Mandatory - Name of the application"
  default     = "evo"
}

variable "AWS_REGION" {
  description = "Mandatory - AWS region when resouces should be created"
  default     = "us-east-1"
}

variable "tags" {
  description = "Mandatory - Name to be used on all resources as prefix"
  default = {
    Terraform   = "true"
  }
}

#### VPC VARIABLES #########

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "app_subnets" {
  description = "CIDR for app subnets"
  type = list(string)
  default     = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "worker_subnets" {
  description = "CIDR for worker subnets"
  type = list(string)
  default     = ["10.0.10.0/24","10.0.11.0/24"]
}

variable "rds_subnets" {
  description = "CIDR for rds subnets"
  type = list(string)
  default     = ["10.0.21.0/24","10.0.22.0/24"]
}

variable "ec_subnets" {
  description = "CIDR for ec for redis subnets"
  type = list(string)
  default     = ["10.0.51.0/24","10.0.52.0/24"]
}

variable "lb_subnets" {
  description = "CIDR for Load balancer subnets"
  type = list(string)
  default     = ["10.0.61.0/24","10.0.62.0/24"]
}

variable "mgt_subnets" {
  description = "CIDR for mgt subnets"
  type = list(string)
  default     = ["10.0.91.0/24"]
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = true
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  default     = "stop"
}

variable "create_new_key_pair" {
  description = "Create a new key for logging in to the instance. Allowed values true/false"
  default     = false
}

variable "ssh_key_filename" {
  description = "If create_new_key_pair is true, provide public key file."
  default     = "~/.ssh/id_rsa.pub"
}

variable "key_pair_existing" {
  description = "If create_new_key_pair is false, provide existing key pair name here."
  default     = "key-pair-name-already-available"
}

variable "ssh_key_pair_name" {
  description = "If create_new_key_pair is true, provide new key pair name here."
  default     = "new-key-pair-name"
}

# APP Instance Profile

variable "app_instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "app_ami" {
  description = "ID of AMI to use for the instance. Default is Ubuntu 18.04 Bionic amd64"
}

variable "app_instance_type" {
  description = "The type of instance to start"
  default     = "t2.micro"
}

variable "app_instance_suffix" {
  description = "Suffix to append to instance name"
  default     = "app"
}

variable "app_root_volume_size" {
  description = "Size of data partiton in GiB"
  default     = "10"
}

variable "app_data_volume_size" {
  description = "Size of data partiton in GiB"
  default     = "10"
}

# Managament Instance Profile

variable "mgt_instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "mgt_ami" {
  description = "ID of AMI to use for the instance. Default is Ubuntu 18.04 Bionic amd64"
}

variable "mgt_instance_type" {
  description = "The type of instance to start"
  default     = "t2.micro"
}

variable "mgt_instance_suffix" {
  description = "Suffix to append to instance name"
  default     = "mgt"
}

variable "mgt_root_volume_size" {
  description = "Size of data partiton in GiB"
  default     = "10"
}

variable "mgt_data_volume_size" {
  description = "Size of data partiton in GiB"
  default     = "10"
}

### DATABASE VARIABLES ###

variable "mysql_version" {
  description = "Mysql Version"
  default     = "5.6.40"
}

variable "mysql_instance_type" {
  description = "Mysql instance type"
  default     = "db.t2.large"
}

variable "mysql_storage" {
  description = "Mysql Instance Storage size"
  default     = 5
}

variable "database_name" {
  description = "Database Name"
}

variable "database_user" {
  description = "Database user or admin user"
}

variable "database_passwd" {
  description = "Database user/admin user password"
}

variable "database_port" {
  description = "Mysql Port Number"
  default     = "3306"
}

variable "master_db_identifier" {
  description = "Name of the database master instance to be created"
}

variable "replica_db_identifier" {
  description = "Name of the database replica instance to be created"
}

variable "auto_minor_version_upgrade" {
  description = "Whether the database should be automatically upgraded to the latest minor version"
  default = false
}

variable "db_parameters" {
  description = "A map of DB parameter options to apply For eg: pgroup_parameters = { character_set_server = utf8 }"
  type = map
  default     = {}
}

variable "deletion_protection" {
  description = "Whether the instance will allow itself to be deleted"
  default = true
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh:24mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default = "Mon:00:05-Mon:03:00"
}

variable "master_backup_retention_period" {
  description = "The days to retain backups for"
  default = 7
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  default = "03:00-05:00"
}

# Load Balancer

variable "enable_https" {
  description = "Enable https traffic"
  default     = true
}

variable "cert_crt_file_path" {
  description = "Certificate .crt file path"
  default     = "../certs/server.crt"
}

variable "cert_key_file_path" {
  description = "Certificate .key file path"
  default     = "../certs/server.key"
}

variable "cert_chain_file_path" {
  description = "Certificate .chain file path"
  default     = "../certs/server.chain"
}

variable "enable_cloudwatch" {
  description = "Enable Cloudwatch monitoring"
  default     = false
}

variable "required_data_partition" {
  description = "Data partition to be created and attached"
  default     = "false"
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  default     = 60
}

variable "ec2_memory_utilization_threshold" {
  description = "Defines a percentage of memory usage that will trigger the cloudwatch alarm"
  default     = 85
}

variable "ec2_root_device_name" {
  description = "The name of the ec2 instance root device"
  default     = "xvda1"
}

variable "rds_burst_balance_threshold" {
  description = "Defines a percentage of used burst balance to trigger the cloudwatch alarm"
  default     = 20
}

variable "rds_free_storage_space_threshold" {
  description = "Defines how much storage (in bytes) should be used up in order to trigger the cloudwatch alarm"
  default     = "2000000000"
}
