module "main-alb" {
  source = "../modules/loadbalancer/"

  name = var.name
  tags = merge(var.tags, {"Environment" = terraform.workspace})

  vpc_id          = element(module.main-vpc.vpc[*].id, 0)
  security_groups = module.main-sg.lb_sg[*].id
  subnets         = module.main-vpc.lb_subnets[*].id

  enable_https = var.enable_https
  idle_timeout    = var.idle_timeout

  app_instance_count = var.app_instance_count

  cert_crt_file_path   = var.cert_crt_file_path
  cert_key_file_path   = var.cert_key_file_path
  cert_chain_file_path = var.cert_chain_file_path

  http_target_group = {
    name             = "http-target-group-1"
    backend_protocol = "HTTP"
    backend_port     = 80
  }

  https_target_group = {
    name             = "https-target-group-1"
    backend_port     = 443
    backend_protocol = "HTTPS"
  }

  http_tcp_listeners = [
    {
      port     = 80
      protocol = "HTTP"
    },
  ]

  https_listeners = [
    {
      port     = 443
      protocol = "HTTPS"
    },
  ]

  target_ids = module.app-ec2.ec2_details[*].id
}
