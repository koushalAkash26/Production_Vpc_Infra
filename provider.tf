terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.74.0"
    }
  }
  backend "s3" {
    bucket         	   = "mybucketbackendterraformpoc"
    key              	 = "terraform.tfstate"
    region         	   = "us-east-1"
    encrypt        	   = true
    dynamodb_table     = "LockProtector"
  }
}

provider "aws" {
  region = "us-east-1"
}