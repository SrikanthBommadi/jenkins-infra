terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.95.0"
    }
  }

  backend "s3" {
    bucket = "srikanth.tf" #bucket only for one project s3 bucket
    key    = "eks-eks"
    region = "us-east-1"
     encrypt = true
    use_lockfile = true
    #dynamodb_table = "srikanth.tf"   #only for onr table 
  }
}
provider "aws" {
  # Configuration options
}