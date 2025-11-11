resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = { Name = "jenkins-vpc" }
}

resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = { Name = "jenkins-subnet" }
}

resource "aws_security_group" "jenkins_sg" {
  vpc_id = aws_vpc.main_vpc.id
  name   = "jenkins-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "jenkins-sg" }
}

resource "aws_instance" "demo_server" {
  ami                    = "ami-087d1c9a513324697"
  instance_type          = "t2.medium"
  key_name               = var.key_name
  subnet_id              = aws_subnet.main_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  tags = { Name = "jenkins-demo-ec2" }
}
