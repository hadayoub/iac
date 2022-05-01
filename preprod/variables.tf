#vpc cidr block
variable "vpc_cidr_block" {
  type = string
  description = "this is the vpc cidr block"
}
#environement
variable "environment" {
  type = string
  description = "this is the environement"
}