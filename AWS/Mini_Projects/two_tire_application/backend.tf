terraform {
  backend "s3" {
    bucket  = "myawsbucket-study"
    encrypt = false
    key     = "terraform/two_tire_application"
    region  = "us-east-1"
  }
}