module "vpc" {
  source = "../../modules/vpc"

  name                     = var.project_name
  vpc_cidr                 = var.vpc_cidr
  azs                      = var.azs
  public_subnet_cidrs      = var.public_subnet_cidrs
  private_app_subnet_cidrs = var.private_app_subnet_cidrs
  private_db_subnet_cidrs  = var.private_db_subnet_cidrs
  enable_nat_gateway       = var.enable_nat_gateway

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
