terraform {
  backend "s3" {
    bucket = "terraform-state-backend-s3-bucket"
    key = "terraform.tfstate"
    region = "eu-central-1"
  }
}
provider "aws" {
  region = "eu-central-1"
}
resource "aws_s3_bucket" "bucket" {
  bucket = "terraform-state-backend-s3-bucket"
}