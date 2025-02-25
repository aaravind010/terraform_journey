resource "aws_key_pair" "terra" {
  key_name = "terra"
  public_key = file("/workspaces/terraform_journey/AWS/Mini_Projects/medium.com/achinthabandaranaike/lab_5_three_tire_app/modules/key_pair/terra.pub")
}