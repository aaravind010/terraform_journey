# Create EC2 instance for Jenkis with default options.

resource "aws_security_group" "jenkins_sg" {
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
}

resource "aws_instance" "jenkins" {
  ami                         = "ami-04b4f1a9cf54c11d0"
  associate_public_ip_address = true
  availability_zone           = "us-east-1a"
  instance_type               = "t3.medium"
  #security_groups             = [aws_security_group.jenkins_sg.id]
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  key_name               = "My-N.Virginia"

  connection {
    user        = "ubuntu"
    port        = 22
    host        = self.public_ip
    type        = "ssh"
    private_key = file("/workspaces/terraform_journey/AWS/Mini_Projects/jenkins/My-N.Virginia.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update && sudo apt upgrade -y",
      "sudo apt install fontconfig openjdk-17-jre -y",
      "terraform apply -auto-approve"
    ]
  }
}