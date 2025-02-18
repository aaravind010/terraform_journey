terraform {
  backend "s3" {
    bucket = "myawsbucket-study"
    key = "terraform/lab_3_two_tire_app_module"
    encrypt = false
    region = "us-east-1"

  }
}