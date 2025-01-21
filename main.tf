resource "aws_vpc" "net" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "Virtual-Network"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.net.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.az[0]
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-Subnet"
    }
  
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.net.id
    tags = {
        Name = "vpc-internet-gateway"
    }
  
}


resource "aws_route_table" "rt-pub" {
  vpc_id = aws_vpc.net.id
  tags = {
    Name = "RT-Public"
  }

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "rta" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.rt-pub.id
  
}

resource "aws_security_group" "sg" {
    name = "firewall-vnet"
    vpc_id = aws_vpc.net.id

    ingress {
       from_port = var.port_no[1]
       to_port = var.port_no[1]
       protocol = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = var.port_no[0]
        to_port = var.port_no[0]
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
  
}

resource "aws_instance" "server" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = aws_subnet.public.id
    availability_zone =var.az[0]
    vpc_security_group_ids = [aws_security_group.sg.id]
    key_name = var.key
    tags = {
        Name = "Public-Instance"
    }
}
