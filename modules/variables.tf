#vpc cidr block
variable "vpc_cidr_block" {
  type        = string
  description = "this is the vpc cidr block"
}

#subnet cidr block
variable "subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "this is the subnet cidr block"
}

#environment
variable "environment" {
  type        = string
  default     = "null"
  description = "this is the environment"
}

#vpc tags
variable "vpc_tags" {
  type = map(string)
  default = {
    Name = "vpc_tags"
  }
  description = "this is the vpc tags"
}
#subnet tags
variable "subnet_tags" {
  type = map(string)
  default = {
    Name = "subnet_tags"
  }
  description = "this is the subnet tags"
}
#instance tag
variable "ec2_tags" {
  type = map(string)
  default = {
    Name = "ec2_tags"
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
