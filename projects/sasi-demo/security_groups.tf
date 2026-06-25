############################################
# Web tier - public-facing (HTTP/HTTPS)
############################################
module "web_sg" {
  source = "../../modules/security-group"

  name        = "${var.project_name}-web"
  vpc_id      = module.vpc.vpc_id
  description = "Web tier - allow HTTP/HTTPS from the internet"

  ingress_rules = [
    {
      description = "HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Tier        = "web"
  }
}

############################################
# App tier - reachable only from web SG
############################################
module "app_sg" {
  source = "../../modules/security-group"

  name        = "${var.project_name}-app"
  vpc_id      = module.vpc.vpc_id
  description = "App tier - allow traffic from web tier only"

  ingress_rules = [
    {
      description     = "App port from web SG"
      from_port       = 3000
      to_port         = 3000
      protocol        = "tcp"
      security_groups = [module.web_sg.security_group_id]
    }
  ]

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Tier        = "app"
  }
}

############################################
# DB tier - reachable only from app SG (MySQL)
############################################
module "db_sg" {
  source = "../../modules/security-group"

  name        = "${var.project_name}-db"
  vpc_id      = module.vpc.vpc_id
  description = "DB tier - allow PSQL from app tier only"

  ingress_rules = [
    {
      description     = "PSQL from app SG"
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      security_groups = [module.app_sg.security_group_id]
    }
  ]

  tags = {
    Project     = var.project_name
    Environment = var.environment
    Tier        = "db"
  }
}
