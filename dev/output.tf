output "vpc_cidr_block" {
  value = var.vpc_cidr_block
}
output "environment" {
  value = var.environment
}
output "subnet_cidr_block" {
  value = var.subnet_cidr_block
}
/* output "tags" {
  value       = "${module.aws_subnet.tags.Name}"
} */
output "subnet_tags" {
  value = var.subnet_tags
}
output "ec2_tags" {
  value = var.ec2_tags
}
