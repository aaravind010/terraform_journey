resource "aws_vpc" "arima_vpc" {
  cidr_block = var.arima_vpc_cidr
  tags = {
    Name = "Arima VPC DEV"
  }
}

resource "aws_subnet" "arima_public_subnet_1" {
  vpc_id                  = aws_vpc.arima_vpc.id
  cidr_block              = var.arima_public_subnet["pub_1"]
  availability_zone       = var.arima_public_azs["pub_1"]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "arima_public_subnet_2" {
  vpc_id                  = aws_vpc.arima_vpc.id
  cidr_block              = var.arima_public_subnet["pub_2"]
  availability_zone       = var.arima_public_azs["pub_2"]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_internet_gateway" "arima_IGW" {
  vpc_id = aws_vpc.arima_vpc.id
  tags = {
    Name = "Arima IGW"
  }
}

resource "aws_route_table" "arima_public_rt_1" {
  vpc_id = aws_vpc.arima_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.arima_IGW.id
  }
}

resource "aws_route_table_association" "public_rt_1_association" {
  route_table_id = aws_route_table.arima_public_rt_1.id
  subnet_id      = aws_subnet.arima_public_subnet_1.id
}


resource "aws_subnet" "arima_private_subnet_1" {
  vpc_id            = aws_vpc.arima_vpc.id
  cidr_block        = var.arima_private_subnet["pri_1"]
  availability_zone = var.arima_private_azs["pri_1"]
  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "arima_private_subnet_2" {
  vpc_id            = aws_vpc.arima_vpc.id
  cidr_block        = var.arima_private_subnet["pri_2"]
  availability_zone = var.arima_private_azs["pri_2"]
  tags = {
    Name = "Private Subnet 2"
  }
}

resource "aws_eip" "arima_eip_nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "arima_nat_gw" {
  subnet_id     = aws_subnet.arima_public_subnet_1.id
  allocation_id = aws_eip.arima_eip_nat.id

  tags = {
    Name = "Arima NAT GW"
  }
}
resource "aws_route_table" "arima_private_rt_1" {
  vpc_id = aws_vpc.arima_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.arima_nat_gw.id
  }
}

resource "aws_route_table_association" "private_rt_1_association" {
  route_table_id = aws_route_table.arima_private_rt_1.id
  subnet_id      = aws_subnet.arima_private_subnet_1.id
}

resource "aws_key_pair" "terra" {
  public_key = file("terra.pub")
  key_name   = "terra-ssh-key"
}

resource "aws_instance" "tera_inst" {
  instance_type = var.ec2_instance_type["pub"]
  subnet_id     = aws_subnet.arima_public_subnet_1.id
  ami           = var.ec2_ami_type["pub"]

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("terra")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install php php-mysqlnd httpd -y",
      "wget https://wordpress.org/wordpress-4.8.14.tar.gz",
      "tar -xzf wordpress-4.8.14.tar.gz",
      "sudo cp -r wordpress /var/www/html/",
      "sudo chown -R apache.apache /var/www/html/",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo systemctl restart httpd"
    ]
  }
}
