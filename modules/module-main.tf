#VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags =  var.vpc_tags
}

#SUBNETS PUBLIC
resource "aws_subnet" "my_pub_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  tags = var.subnet_tags
}
resource "aws_subnet" "my_pub_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  tags = var.subnet_tags
}
resource "aws_subnet" "my_pub_subnet_3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  tags = var.subnet_tags
}

#SUBNETS PRIVATE
resource "aws_subnet" "my_prv_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = false
  tags = var.subnet_tags
  }

resource "aws_subnet" "my_prv_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = false
  tags = var.subnet_tags
}
resource "aws_subnet" "my_prv_subnet_3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = false
  tags = var.subnet_tags
}

#INTERNET GATEWAY (PUBLIC SUBNETS NEED TO BE CONNECTED TO INTERNET GATEWAY)
resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id
}

#ROUTE TABLE
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_internet_gateway.id
  }

  tags = {
    Name = "route table"
  }
}

#ROUTE TABLE ASSOCIATIONS
resource "aws_route_table_association" "route_table_association_1" {
  subnet_id      = aws_subnet.my_pub_subnet_1.id
  route_table_id = aws_route_table.my_route_table.id
}
resource "aws_route_table_association" "route_table_association_2" {
  subnet_id      = aws_subnet.my_pub_subnet_2.id
  route_table_id = aws_route_table.my_route_table.id
}
resource "aws_route_table_association" "route_table_association_3" {
  subnet_id      = aws_subnet.my_pub_subnet_2.id
  route_table_id = aws_route_table.my_route_table.id
}

#SECURITY GROUPE
resource "aws_security_group" "my_sg" {
  name        = "security groupe"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.my_vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security groupe"
  }
}

#S3 
resource "aws_s3_bucket" "my_s3" {
  bucket = "my_bucket_s3"

  tags = {
    Name        = "bucket"
    Environment = var.environment
  }
}
resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.my_s3.id
  acl    = "private"
}

#EC2
resource "aws_instance" "my_ec2" {
  ami           = "ami-063a9ea2ff5685f7f"
  instance_type = "t3.micro"
  tags = {
    Name = "ec2"
  }
}

#EBS VOLUME
resource "aws_ebs_volume" "my_ebs_volume" {
  availability_zone = "us-west-2a"
  size              = 40

  tags = {
    Name = "ebs volume"
  }
}

#EBS VOLUME ATTACHEMENT
resource "aws_volume_attachment" "my_ebs_volume_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.my_ebs_volume.id
  instance_id = aws_instance.my_ec2.id
}

#IAM GROUPE
resource "aws_iam_group" "developers" {
  name = "developers"
  path = "/users/"
}
resource "aws_iam_group" "managers" {
  name = "managers"
  path = "/users/"
}
resource "aws_iam_group" "admins" {
  name = "admins"
  path = "/admin/"
}

#IAM USERS
resource "aws_iam_user" "developer_1" {
  name = "developer_1"
}
resource "aws_iam_user" "manager_1" {
  name = "manager_1"
}
resource "aws_iam_user" "admin_1" {
  name = "admin_1"
}

#IAM GROUPE MEMBERSHIP
resource "aws_iam_group_membership" "team_developers" {
  name = "team_developers"

  users = [
    aws_iam_user.developer_1.name
  ]

  group = aws_iam_group.developers.name
}

#---------------------------------
resource "aws_iam_group_membership" "team_admins" {
  name = "team_admins"

  users = [
    aws_iam_user.admin_1.name
  ]

  group = aws_iam_group.admins.name
}
#---------------------------------
resource "aws_iam_group_membership" "team_managers" {
  name = "team_managers"

  users = [
    aws_iam_user.manager_1.name
  ]

  group = aws_iam_group.managers.name
}
#---------------------------------

#PROFIL
resource "aws_iam_instance_profile" "admin_profile" {
  name = "admin_profile"
  role = aws_iam_role.admine_role.name
}
#ROLE DE PROFIL
resource "aws_iam_role" "admine_role" {
  name = "admine_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

#RDS
resource "aws_db_instance" "mysql" {
  allocated_storage    = 100
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "username"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

