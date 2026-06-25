# terraform-aws

Reusable AWS VPC module plus per-project consumers.

## Layout

```
terraform-aws/
├── modules/
│   └── vpc/                  # Reusable VPC module
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── versions.tf
└── projects/
    └── sasi-demo/             # Sample consumer; copy this folder per project
        ├── provider.tf
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── terraform.tfvars
```

## What the VPC module creates

- VPC (`10.0.0.0/16` by default)
- 2 public subnets, 2 private app subnets, 2 private db subnets (across 2 AZs)
- Internet Gateway
- NAT Gateway in the first public subnet (AZ "a"), with one EIP
- Public route table (0.0.0.0/0 -> IGW), associated with public subnets
- Private route table (0.0.0.0/0 -> NAT), associated with all 4 private subnets

Everything is variablized — CIDRs, AZs, name prefix, tags, and NAT toggle.

## Use the module from a new project

1. Copy `projects/sasi-demo` to `projects/<your-project>`.
2. Edit `terraform.tfvars` and set `project_name` to your project name.
3. Run:

```pwsh
cd projects/<your-project>
terraform init
terraform plan
terraform apply
```

## Consuming the module directly

```hcl
module "vpc" {
  source = "../../modules/vpc"

  name                     = "myapp-dev"
  vpc_cidr                 = "10.0.0.0/16"
  azs                      = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs      = ["10.0.1.0/24", "10.0.2.0/24"]
  private_app_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  private_db_subnet_cidrs  = ["10.0.21.0/24", "10.0.22.0/24"]
  enable_nat_gateway       = true

  tags = {
    Project     = "myapp"
    Environment = "dev"
  }
}
```
