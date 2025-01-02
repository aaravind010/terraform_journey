resource "aws_instance" "tf_ec2_1" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.small"

  tags = {
    Name = "First TF Instance"
  }
}