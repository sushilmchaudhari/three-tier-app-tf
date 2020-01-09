terraform {
  required_version = ">= 0.10.3" # Local Values configuration feature is allowed only in higher versions of Terraform
}

locals {
  envi = terraform.workspace
}

##################################
# MANAGEMENT SECURITY GROUP
##################################

resource "aws_security_group" "mgt" {

  count = var.create_sg ? 1 : 0
  name        = format("%s-%s-mgt-sg", var.name, local.envi)
  description = "Security Group for Management Resources"
  vpc_id      = var.vpc-id

  tags = merge(var.tags_sg, {"Name" = format("%s-%s-mgt-sg", var.name, local.envi)})
}

resource "aws_security_group_rule" "mgt_ingress" {
  count = var.create_sg ? length(var.mgt_ingress_rules) : 0

  security_group_id = aws_security_group.mgt[0].id
  type              = "ingress"

  cidr_blocks      = lookup(var.mgt_ingress_rules[count.index], "cidr_blocks")

  from_port = lookup(var.mgt_ingress_rules[count.index], "from_port", 0)
  to_port   = lookup(var.mgt_ingress_rules[count.index], "to_port", 0)
  protocol  = lookup(var.mgt_ingress_rules[count.index], "protocol", "tcp")
  description = lookup(var.mgt_ingress_rules[count.index], "description", "")
}

resource "aws_security_group_rule" "mgt_egress" {
  count = var.create_sg ? length(var.mgt_egress_rules) : 0

  security_group_id = aws_security_group.mgt[0].id
  type              = "egress"

  cidr_blocks      = lookup(var.mgt_egress_rules[count.index], "cidr_blocks")

  from_port = lookup(var.mgt_egress_rules[count.index], "from_port")
  to_port   = lookup(var.mgt_egress_rules[count.index], "to_port")
  protocol  = lookup(var.mgt_egress_rules[count.index], "protocol")
  description = lookup(var.mgt_egress_rules[count.index], "description", "")
}

##################################
# LOAD BALANCER SECURITY GROUP
##################################

resource "aws_security_group" "lb" {

  count = var.create_sg ? 1 : 0
  name        = format("%s-%s-lb-sg", var.name, local.envi)
  description = "Security Group for Load Balancer"
  vpc_id      = var.vpc-id

  tags = merge(var.tags_sg, {"Name" = format("%s-%s-lb-sg", var.name, local.envi)})
}

resource "aws_security_group_rule" "lb_ingress" {
  count = var.create_sg ? length(var.lb_ingress_rules) : 0

  security_group_id = aws_security_group.lb[0].id
  type              = "ingress"

  cidr_blocks      = lookup(var.lb_ingress_rules[count.index], "cidr_blocks")

  from_port = lookup(var.lb_ingress_rules[count.index], "from_port", 0)
  to_port   = lookup(var.lb_ingress_rules[count.index], "to_port", 0)
  protocol  = lookup(var.lb_ingress_rules[count.index], "protocol", "tcp")
  description = lookup(var.lb_ingress_rules[count.index], "description", "")
}

resource "aws_security_group_rule" "lb_egress" {
  count = var.create_sg ? length(var.lb_egress_rules) : 0

  security_group_id = aws_security_group.lb[0].id
  type              = "egress"

  cidr_blocks      = lookup(var.lb_egress_rules[count.index], "cidr_blocks")

  from_port = lookup(var.lb_egress_rules[count.index], "from_port")
  to_port   = lookup(var.lb_egress_rules[count.index], "to_port")
  protocol  = lookup(var.lb_egress_rules[count.index], "protocol")
  description = lookup(var.lb_egress_rules[count.index], "description", "")
}

##################################
# APPLICATION SECURITY GROUP
##################################

resource "aws_security_group" "app" {

  count = var.create_sg ? 1 : 0
  name        = format("%s-%s-app-sg", var.name, local.envi)
  description = "Security Group for Load Balancer"
  vpc_id      = var.vpc-id

  tags = merge(var.tags_sg, {"Name" = format("%s-%s-app-sg", var.name, local.envi)})
}

resource "aws_security_group_rule" "app_ingress" {
  count = var.create_sg ? length(var.app_ingress_rules) : 0

  security_group_id = aws_security_group.app[0].id
  type              = "ingress"

  cidr_blocks      = lookup(var.app_ingress_rules[count.index], "cidr_blocks")

  from_port = lookup(var.app_ingress_rules[count.index], "from_port", 0)
  to_port   = lookup(var.app_ingress_rules[count.index], "to_port", 0)
  protocol  = lookup(var.app_ingress_rules[count.index], "protocol", "tcp")
  description = lookup(var.app_ingress_rules[count.index], "description", "")
}

resource "aws_security_group_rule" "app_egress" {
  count = var.create_sg ? length(var.app_egress_rules) : 0

  security_group_id = aws_security_group.app[0].id
  type              = "egress"

  cidr_blocks      = lookup(var.app_egress_rules[count.index], "cidr_blocks")

  from_port = lookup(var.app_egress_rules[count.index], "from_port")
  to_port   = lookup(var.app_egress_rules[count.index], "to_port")
  protocol  = lookup(var.app_egress_rules[count.index], "protocol")
  description = lookup(var.app_egress_rules[count.index], "description", "")
}


##################################
# RDS DATABASE SECURITY GROUP
##################################

resource "aws_security_group" "rds" {

  count = var.create_sg ? 1 : 0
  name        = format("%s-%s-rds-sg", var.name, local.envi)
  description = "Security Group for RDS Database"
  vpc_id      = var.vpc-id

  tags = merge(var.tags_sg, {"Name" = format("%s-%s-rds-sg", var.name, local.envi)})
}

resource "aws_security_group_rule" "rds_ingress" {
  count = var.create_sg ? length(var.rds_ingress_rules) : 0

  security_group_id = aws_security_group.rds[0].id
  type              = "ingress"

  cidr_blocks      = lookup(var.rds_ingress_rules[count.index], "cidr_blocks")

  from_port = lookup(var.rds_ingress_rules[count.index], "from_port", 0)
  to_port   = lookup(var.rds_ingress_rules[count.index], "to_port", 0)
  protocol  = lookup(var.rds_ingress_rules[count.index], "protocol", "tcp")
  description = lookup(var.rds_ingress_rules[count.index], "description", "")
}

resource "aws_security_group_rule" "rds_egress" {
  count = var.create_sg ? length(var.rds_egress_rules) : 0

  security_group_id = aws_security_group.rds[0].id
  type              = "egress"

  cidr_blocks      = lookup(var.rds_egress_rules[count.index], "cidr_blocks")

  from_port = lookup(var.rds_egress_rules[count.index], "from_port")
  to_port   = lookup(var.rds_egress_rules[count.index], "to_port")
  protocol  = lookup(var.rds_egress_rules[count.index], "protocol")
  description = lookup(var.rds_egress_rules[count.index], "description", "")
}
