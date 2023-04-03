provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment_id
      Role        = "${var.environment_name}-State-bucket"
      Purpose     = var.purpose
    }
  }
}

module "versions" {
  source = "../../../modules/aws_versions"
}

module "aws_network" {
  source                   = "../../../modules/aws_network"
  region                   = var.region
  environment_name         = var.environment_name
  environment_id           = var.environment_id
  purpose                  = var.purpose
  state_bucket             = var.state_bucket
  zones                    = var.zones
  vpc_cidr                 = var.vpc_cidr
  public_zone_name         = var.public_zone_name
  has_single_nat_gateway   = var.has_single_nat_gateway
}
