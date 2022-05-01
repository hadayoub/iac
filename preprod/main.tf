module "aws_vpc" {
  source        = "../modules"
  vpc_cidr_block = var.vpc_cidr_block
}
module "aws_s3_bucket" {
  source        = "../modules"
  environment = var.environment
  vpc_cidr_block = var.vpc_cidr_block
}