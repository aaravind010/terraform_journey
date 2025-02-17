module "subnet" {
  source = "../subnet"
}

module "key_pair" {
  source = "../key_pair"
}

module "ec2_sg" {
  source = "../securitygroup"
}

resource "aws_instance" "bastion_web" {
  ami = var.ec2_ami_type["pub"]
  instance_type = var.ec2_instance_type["pub"]
  subnet_id = module.subnet.public_subnet_1_id
  key_name = module.key_pair.key_pair
  security_groups = [ module.ec2_sg.bastion_sg_id ]

  tags = {
    Name = "Bastion web server"
  }

  connection {
    host = self.public_ip
    user = "ec2-user"
    port = 22
    type = "ssh"
    private_key = file("/workspaces/terraform_journey/AWS/Mini_Projects/two_tire_application/modules/ec2/terra")
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

resource "aws_instance" "bastion_web_2" {
  ami = var.ec2_ami_type["pub"]
  instance_type = var.ec2_instance_type["pub"]
  subnet_id = module.subnet.public_subnet_2_id
  key_name = module.key_pair.key_pair
  security_groups = [ module.ec2_sg.bastion_sg_id ]

  tags = {
    Name = "Bastion web server"
  }

  connection {
    host = self.public_ip
    user = "ec2-user"
    port = 22
    type = "ssh"
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