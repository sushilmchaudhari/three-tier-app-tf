
locals {
  envi = terraform.workspace
}

resource "aws_eip" "pub_ip_fixed" {
  count = var.required_fixed_public_ip ? var.instance_count : 0
  vpc = true
  tags = merge({"Name" = format("%s-${local.envi}-%s-eip-%s", var.name, var.ec2_suffix, count.index+1)}, var.tags)
}

resource "aws_instance" "server" {

  count = var.instance_count

  ami                    = var.ami
  instance_type          = var.instance_type

  # Instance Subnets where want to place your instance (app/worker/management etc)
  subnet_id              = element(var.subnet_ids,count.index)
  availability_zone      = element(var.az_ids,count.index)
  vpc_security_group_ids = var.vpc_security_group_ids

  iam_instance_profile   = var.iam_instance_profile

  associate_public_ip_address = var.associate_public_ip_address

  source_dest_check                    = var.source_dest_check

  disable_api_termination              = var.disable_api_termination

  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior

  tenancy                              = var.tenancy

  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_volume_size
    delete_on_termination = true
  }

  user_data = data.template_cloudinit_config.config.rendered

  key_name = var.key_pair_name

  tags = merge( var.tags, {"Name" = format("%s-%s-%s-ec2-%s-%d", var.name, local.envi, var.ec2_suffix, element(var.az_ids, count.index) ,count.index+1)}, {"Ansible Group" = var.ec2_suffix})
  volume_tags = merge({"Name" = format("%s-%s-%s-root-%s-%d", var.name, local.envi, var.ec2_suffix, element(var.az_ids, count.index), count.index+1)}, var.tags)

  lifecycle {
    ignore_changes = ["volume_tags"]
  }

  depends_on = ["aws_ebs_volume.data"]
}

resource "aws_volume_attachment" "current_ec2" {
  count = var.required_data_partition ? var.instance_count : 0

  device_name = "/dev/xvdn"
  volume_id   = aws_ebs_volume.data[count.index].id
  instance_id = aws_instance.server[count.index].id
  skip_destroy = true
}

resource "aws_ebs_volume" "data" {
  count = var.required_data_partition ? var.instance_count : 0

  type              = "gp2"
  availability_zone = element(var.az_ids, count.index)
  size              = var.data_volume_size
  tags              = merge({"Name" = format("%s-%s-%s-data-%s-%d", var.name, local.envi, var.ec2_suffix, element(var.az_ids, count.index) ,count.index+1)}, var.tags)
}

resource "aws_eip_association" "eip_assoc" {
  count = var.required_fixed_public_ip ? var.instance_count : 0
  instance_id   = element(aws_instance.server[*].id, count.index)
  allocation_id = element(aws_eip.pub_ip_fixed[*].id, count.index)
}
