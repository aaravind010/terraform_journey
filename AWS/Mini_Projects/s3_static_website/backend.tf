terraform {
  backend "s3" {
    bucket = "myawsbucket-study"
    key = "terraform/s3_static_website"
    encrypt = false
    region = "us-east-1"

  }
}