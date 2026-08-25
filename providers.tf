provider "aws" {
  region = local.region
}

terraform {
  required_version = "<=1.16.0" #This is the Terraform Version

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.60.0" #This is the AWS Provider Version
    }
  }
}