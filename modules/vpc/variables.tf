#####################
# AVAILABILITY ZONE
#####################

variable "azs" {
  description = "A list of availability zones in the region"
  default     = []
}

#####################
# NAME and TAGS
#####################

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

#####################
# VPC
#####################

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  default     = true
}

variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "assign_generated_ipv6_cidr_block" {
  description = "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block"
  default     = false
}

variable "secondary_cidr_blocks" {
  description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
  default     = []
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  default     = false
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  default     = true
}


#####################
# APPLICATION
#####################

variable "app_subnets" {
  description = "A list of app subnets inside the VPC"
  type = list(string)
  default     = []
}

# NACL
variable "app_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for app subnets"
  default     = false
}

variable "app_inbound_acl_rules" {
  description = "app subnets inbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "app_outbound_acl_rules" {
  description = "app subnets outbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

#####################
# RDS DATABASE
#####################

variable "rds_subnets" {
  description = "A list of rds subnets"
  type = list(string)
  default     = []
}

# Subnet Group
variable "create_rds_subnet_group" {
  description = "Controls if rds subnet group should be created"
  default     = true
}

# Route Table
variable "create_rds_subnet_route_table" {
  description = "Controls if separate route table for rds should be created"
  default     = false
}

variable "create_rds_internet_gateway_route" {
  description = "Controls if an internet gateway route for public rds access should be created"
  default     = false
}

# NACL
variable "rds_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for rds subnets"
  default     = false
}

variable "rds_inbound_acl_rules" {
  description = "rds subnets inbound network ACL rules"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "rds_outbound_acl_rules" {
  description = "rds subnets outbound network ACL rules"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}


##############################
# PUBLIC / MANAGEMENT / LB
##############################

variable "map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  default     = true
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type = list(string)
  default     = []
}

# NACL
variable "public_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for public subnets"
  default     = false
}

variable "public_inbound_acl_rules" {
  description = "Public subnets inbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "public_outbound_acl_rules" {
  description = "Public subnets outbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

##############################
# Load Balancer
##############################

variable "lb_map_public_ip_on_launch" {
  description = "Should be false if you do not want to auto-assign public IP on launch"
  default     = false
}

variable "lb_subnets" {
  description = "A list of public subnets inside the VPC"
  type = list(string)
  default     = []
}

# NACL
variable "lb_dedicated_network_acl" {
  description = "Whether to use dedicated network ACL (not default) and custom rules for public subnets"
  default     = false
}

variable "lb_inbound_acl_rules" {
  description = "Public subnets inbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable "lb_outbound_acl_rules" {
  description = "Public subnets outbound network ACLs"

  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}



##############################
# NAT DEVICE
##############################

variable "enable_nat_gateway" {
  description = "Should be true if you want to provision NAT Gateways for each of your app networks"
  default     = false
}

variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your app networks"
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Should be true if you want only one NAT Gateway per availability zone. Requires `var.azs` to be set, and the number of `public_subnets` created to be greater than or equal to the number of availability zones specified in `var.azs`."
  default     = false
}

variable "reuse_nat_ips" {
  description = "Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable"
  default     = false
}

variable "external_nat_ip_ids" {
  description = "List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)"

  default = []
}

##############################
# ENDPOINTS
##############################

variable "enable_s3_endpoint" {
  description = "Should be true if you want to provision an S3 endpoint to the VPC"
  default     = false
}
