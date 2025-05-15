terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }

  backend "s3" {
    bucket = "srikanth.tf" #bucket only for one project s3 bucket
    key    = "expense-vpc"
    region = "us-east-1"
    dynamodb_table = "srikanth.tf"   #only for onr table 
  }
}
provider "aws" {
  # Configuration options
}