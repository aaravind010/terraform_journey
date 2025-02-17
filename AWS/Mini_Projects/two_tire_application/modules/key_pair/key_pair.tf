resource "aws_key_pair" "terra" {
  key_name   = "terra"
  public_key = file("terra.pub")
}

output "key_pair" {
  value = aws_key_pair.terra.key_name
}