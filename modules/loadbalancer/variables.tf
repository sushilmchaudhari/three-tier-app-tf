variable "tags" {
  type        = "map"
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = ""
}

variable "alb_is_internal" {
  description = "load balancer is internal or internet facing, "
  default = "false"
}

variable "security_groups" {
  description = "The security groups to attach to the load balancer."
  type        = "list"
}

variable "subnets" {
  description = "A list of subnets to associate with the load balancer."
  type        = "list"
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  default     = 60
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing."
  default     = true
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer."
  default     = false
}

variable "enable_http2" {
  description = "Indicates whether HTTP/2 is enabled in application load balancers."
  default     = true
}

variable "ip_address_type" {
  description = "The type of IP addresses used by the subnets for your load balancer. Allowed values ipv4/dualstack."
  default     = "ipv4"
}

variable "vpc_id" {
  description = "VPC id where the load balancer and other resources will be deployed."
}

variable "enable_https" {
  description = "Enable https connection. Allowed values true/false"
  default = false
}

variable "http_target_group" {
  description = "A map containing key/value pairs that define the http target group. Allowed key/values: name, backend_protocol, backend_port. Optional key/values are in the target_groups_defaults variable."
  type        = "map"
  default     = {}
}

variable "https_target_group" {
  description = "A map containing key/value pairs that define the https target group. Allowed key/values: name, backend_protocol, backend_port. Optional key/values are in the target_groups_defaults variable."
  type        = "map"
  default     = {}
}

variable "http_tcp_listeners" {
  description = "A list of maps describing the HTTPS listeners for this ALB. Required key/values: port, protocol."
  type        = "list"
  default     = []
}

variable "https_listeners" {
  description = "A list of maps describing the HTTPS listeners for this ALB. Required key/values: port, protocol."
  type        = "list"
  default     = []
}

variable "target_ids" {
  description = "The ID of the target. Instance ID for an instance, or the container ID for an ECS container, or IP address for an ip"
  type = "list"
}

variable "target_group_defaults" {
  type = "map"
  description = "Default values for target groups."
  default = {
    cookie_duration                  = 86400
    deregistration_delay             = 300
    health_check_interval            = 10
    health_check_healthy_threshold   = 3
    health_check_path                = "/index.html"
    health_check_port                = "traffic-port"
    health_check_timeout             = 5
    health_check_unhealthy_threshold = 3
    health_check_matcher             = "200-301"
    stickiness_enabled               = true
    target_type                      = "instance"
    slow_start                       = 0
  }
}

variable "cert_crt_file_path" {
  description = "Certificate .crt file path"
  default = ""
}

variable "cert_key_file_path" {
  description = "Certificate .key file path"
  default = ""
}

variable "cert_chain_file_path" {
  description = "Certificate .chain file path"
  default = ""
}

variable "app_instance_count" {
  description = "Count of application instances to be attached to target groups"
  default = 1
}
