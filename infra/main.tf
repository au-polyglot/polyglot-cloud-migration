resource "aws_vpc" "polyglot_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "polyglot-vpc"
  }
}

resource "aws_subnet" "polyglot_subnet" {
  vpc_id                  = aws_vpc.polyglot_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "polyglot-subnet"
  }
}

resource "aws_internet_gateway" "polyglot_igw" {
  vpc_id = aws_vpc.polyglot_vpc.id
  tags = {
    Name = "polyglot-igw"
  }
}

resource "aws_route_table" "polyglot_rt" {
  vpc_id = aws_vpc.polyglot_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.polyglot_igw.id
  }
}

resource "aws_route_table_association" "polyglot_rta" {
  subnet_id      = aws_subnet.polyglot_subnet.id
  route_table_id = aws_route_table.polyglot_rt.id
}

resource "aws_security_group" "polyglot_sg" {
  name        = "polyglot-sg"
  description = "Allow web and SSH traffic"
  vpc_id      = aws_vpc.polyglot_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8090
    to_port     = 8090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "polyglot_key" {
  key_name   = var.key_name
  public_key = file("${path.module}/polyglot-key.pub")
}

resource "aws_instance" "polyglot_vm" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.polyglot_subnet.id
  vpc_security_group_ids = [aws_security_group.polyglot_sg.id]
  key_name               = aws_key_pair.polyglot_key.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              usermod -a -G docker ec2-user
              curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              chmod +x /usr/local/bin/docker-compose
              EOF

  tags = {
    Name = "polyglot-vm"
  }
}