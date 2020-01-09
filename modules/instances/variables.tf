variable "name" {
  description = "Name to be used on all resources as prefix"
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 1
}

variable "ami" {
  description = "ID of AMI to use for the instance"
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  default     = "default"
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = true
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance" # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/terminating-instances.html#Using_ChangingInstanceInitiatedShutdownBehavior
  default     = "stop"
}

variable "instance_type" {
  description = "The type of instance to start"
}

variable "key_pair_name" {
  description = "The key name to use for the instance"
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = "list"
}

variable "subnet_ids" {
  description = "The VPC Subnet ID to launch in"
  default     = []
  type        = "list"
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  default     = true
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""
}

variable "az_ids" {
  description = "List of availability zone/s"
  type = "list"
  default = []
}

variable "ec2_suffix" {
  description = "EC2 instance suffix like app/worker/mgt"
  default = ""
}

variable "root_volume_size" {
  description = "Root partition size"
  default = "10"
}

variable "data_volume_size" {
  description = "Data partition size"
  default = "10"
}

variable "iam_instance_profile" {
   description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
   default     = ""
 }

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time"
  default     = {}
}

variable "required_data_partition" {
  description = "Data partition to be created and attached"
  default = "false"
}

variable "required_fixed_public_ip" {
  description = "required Elastic/Public Ip to Instance"
  default = "false"
}
