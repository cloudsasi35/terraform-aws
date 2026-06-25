variable "name" {
  description = "Name prefix for the security group. Final Name tag will be \"<name>-sg\"."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the security group will be created."
  type        = string
}

variable "description" {
  description = "Description for the security group."
  type        = string
  default     = "Managed by Terraform"
}

variable "use_name_prefix" {
  description = "If true, use name_prefix (recommended with create_before_destroy)."
  type        = bool
  default     = true
}

variable "ingress_rules" {
  description = <<-EOT
    List of ingress rule objects. Each rule supports:
      - description       (string, optional)
      - from_port         (number, required)
      - to_port           (number, required)
      - protocol          (string, required, e.g. "tcp", "udp", "icmp", "-1")
      - cidr_blocks       (list(string), optional)
      - ipv6_cidr_blocks  (list(string), optional)
      - security_groups   (list(string), optional)  # source SG IDs
      - self              (bool, optional)
      - prefix_list_ids   (list(string), optional)
  EOT
  type        = any
  default     = []
}

variable "egress_rules" {
  description = "List of egress rule objects (same shape as ingress_rules). Defaults to allow-all outbound."
  type        = any
  default = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

variable "tags" {
  description = "Additional tags applied to the security group."
  type        = map(string)
  default     = {}
}
