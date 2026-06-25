variable "region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used as a name prefix for resources."
  type        = string
}

variable "environment" {
  description = "Environment (dev/stage/prod)."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability Zones to use."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the 2 public subnets."
  type        = list(string)
}

variable "private_app_subnet_cidrs" {
  description = "CIDR blocks for the 2 private application subnets."
  type        = list(string)
}

variable "private_db_subnet_cidrs" {
  description = "CIDR blocks for the 2 private database subnets."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to provision a NAT Gateway."
  type        = bool
  default     = true
}
