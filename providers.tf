terraform {
  required_version = "1.12.2"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.9.0"
    }
    github = {
        source = "integrations/github"
        version = "~> 5.0"
    }
  }
}