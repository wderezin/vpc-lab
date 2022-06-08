# terraform and provider blocks

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0, < 5.0"
    }
  }
  required_version = ">= 1.1, < 1.3"
}

provider "aws" {
  region = "us-east-2"
  default_tags {
    tags = {
      Owner = "Walter"
    }
  }
}
