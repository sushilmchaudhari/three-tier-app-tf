
variable "tags_sg" {
  description = "A map of tags to add to all resources"
  default     = {}
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "vpc-id" {
  description = "VPC id where security groups should be created"
  default = ""
}

variable "create_sg" {
  description = "To create security group and all rules"
  default = "false"
}

# management security groups
variable "mgt_ingress_rules" {
  description = "Ingress rules for Management resources"
  default = []
}

variable "mgt_egress_rules" {
  description = "Egress rules for Management resources"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      to_port = 0
      protocol = "all"
      description = "Allow all connections to internet"
    },
  ]
}

# LoadBalancer Security Group
variable "lb_ingress_rules" {
  description = "Ingress rules for Load Balancer"
  default = []
}

variable "lb_egress_rules" {
  description = "Egress rules for Load Balancer"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      to_port = 0
      protocol = "all"
      description = "Allow all connections to internet"
    }
  ]
}

# Application security group
variable "app_ingress_rules" {
  description = "Ingress rules for Evo Application resources with CIDR blocks as source"
  default = []
}

variable "app_egress_rules" {
  description = "Egress rules for Evo Application resources"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      to_port = 0
      protocol = "all"
      description = "Allow all connections to internet"
    }
  ]
}

# RDS security group
variable "rds_ingress_rules" {
  description = "Ingress rules for RDS Database resources"
  default = []
}

variable "rds_egress_rules" {
  description = "Egress rules for RDS Database resources"
  default = [
    {
      cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      to_port = 0
      protocol = "all"
      description = "Allow all connections to internet"
    }
  ]
}
