resource "aws_instance" "bastion_web" {
  ami = var.ec2_ami_type["pub"]
  instance_type = var.ec2_instance_type["pub"]
  subnet_id = aws_subnet.public_subnet_1.id
  key_name = aws_key_pair.terra.terra
  security_groups = [ aws_security_group.bastion_sg.id ]

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

resource "aws_instance" "bastion_web_2" {
  ami = var.ec2_ami_type["pub"]
  instance_type = var.ec2_instance_type["pub"]
  subnet_id = aws_subnet.public_subnet_2.id
  key_name = aws_key_pair.terra.terra
  security_groups = [ aws_security_group.bastion_sg.id ]

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