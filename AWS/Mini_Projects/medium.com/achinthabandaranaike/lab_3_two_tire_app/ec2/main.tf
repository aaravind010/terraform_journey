resource "aws_key_pair" "web_key" {
  key_name   = "terra"
  public_key = file("/workspaces/terraform_journey/AWS/Mini_Projects/medium.com/achinthabandaranaike/lab_3_two_tire_app/ec2/terra.pub")
}

resource "aws_instance" "web_1" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [var.ec2_sg_id]
  subnet_id       = var.pub_sub_1_id
  key_name        = aws_key_pair.web_key.key_name

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    port        = 22
    private_key = file("/workspaces/terraform_journey/AWS/Mini_Projects/medium.com/achinthabandaranaike/lab_3_two_tire_app/ec2/terra")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install php php-mysqlnd httpd -y",
      "sudo echo 'I am from second server' > /var/www/html",
      "sudo chown -R apache.apache /var/www/html/",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo systemctl restart httpd"
    ]
  }
}

resource "aws_instance" "web_2" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [var.ec2_sg_id]
  subnet_id       = var.pub_sub_2_id
  key_name        = aws_key_pair.web_key.key_name

  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ec2-user"
    port        = 22
    private_key = file("/workspaces/terraform_journey/AWS/Mini_Projects/medium.com/achinthabandaranaike/lab_3_two_tire_app/ec2/terra")
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