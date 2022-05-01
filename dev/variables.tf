#vpc cidr block
variable "vpc_cidr_block" {
  type        = string
  description = "this is the vpc cidr block"
}
#subnet cidr block
variable "subnet_cidr_block" {
  type        = string
  description = "this is the subnet cidr block"
}
#environement
variable "environment" {
  type        = string
  description = "this is the environement"
}
#vpc tags
variable "vpc_tags" {
  type = map(string) 
  default = {
    Name = "dev_vpc"
  }
  description = "this is the tags"
}
#subnet tag
variable "subnet_tags" {
  type = map(string) 
  default = {
    Name = "dev_subnet"
  }
  description = "this is the tags"
}

#instance tag
variable "ec2_tags" {
  type = map(string)
  default = {
    Name = "dev_ec2"
  }
  description = "this is the tags"
}

#instance type 
variable "instance_type" {
  type        = string
  default = "t3.micro"
  description = "this is the instance type"
}
#ami
variable "ami" {
  type        = string
  default = "ami-063a9ea2ff5685f7f"
  description = "this is the ami"
}
