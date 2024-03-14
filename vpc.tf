
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = var.project_name
  cidr = var.vpc_cidr

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  public_subnet_tags = merge(var.tags, {
    "SubnetType" = "Public"
  })

  private_subnet_tags = merge(var.tags, {
    "SubnetType" = "Private"
  })

  tags = var.tags
}