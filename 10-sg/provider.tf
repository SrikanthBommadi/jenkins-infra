terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket = "sri.terraform.backend" #bucket only for one project s3 bucket
    key    = "sg-project create"
    region = "us-east-1"
    dynamodb_table = "sri.terraform.backend"   #only for onr table 
  }
}
provider "aws" {
  # Configuration options
}