provider "aws" {
    region = "us-east-1"
    
}


resource "aws_vpc" "vpc-1" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames    = true

  tags = {
    Name = "vpc-1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "vpc_igw"
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "${var.subnet-1}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"


  tags = {
    Name = "subnet-1"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}



resource "aws_security_group" "sg" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.vpc-1.id
  

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    #cidr_blocks      = [aws_vpc.firast-vpc.cidr_block] #List of CIDR Blocks
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http"
  }
}



resource "aws_instance" "web1" {
        ami = "${var.ami}"
        instance_type = "${var.instance_type}"
        #vpc_security_group_ids = [aws_security_group.allow_http.id]
        #associate_public_ip_address = true
        security_groups = [aws_security_group.sg.id]
        
        user_data = <<-EOF
                  #!/bin/bash
                  yum update -y
                  yum install -y httpd
                  systemctl start httpd
                  systemctl enable httpd
                  host_name=`curl -s http://169.254.169.254/latest/meta-data/local-hostname`
                  echo "hi there from $host_name" > /var/www/html/host.html
                  echo "done"
                  EOF
            
        
        subnet_id = aws_subnet.public_subnet.id
        
        tags = {
            Name = "Web1"
        }

    } 



output "public_ip" {
  value = aws_instance.web1.public_ip 
  description = "Public IP of instance server"
}


