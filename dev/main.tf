module "aws_vpc" {
  source         = "../modules"
  vpc_cidr_block = var.vpc_cidr_block
}
module "aws_s3_bucket" {
  source         = "../modules"
  environment    = var.environment
  vpc_cidr_block = var.vpc_cidr_block
}
module "aws_subnet" {
  source            = "../modules"
  environment       = var.environment
  vpc_cidr_block    = var.vpc_cidr_block
  subnet_cidr_block = var.subnet_cidr_block
  subnet_tags       = var.subnet_tags
}
module "aws_instance" {
  source            = "../modules"
  ami           = var.ami
  instance_type = var.instance_type
  vpc_cidr_block = var.vpc_cidr_block
  ec2_tags = var.ec2_tags
}
 