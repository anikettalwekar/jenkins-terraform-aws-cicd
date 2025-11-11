terraform {
  required_version = ">= 1.2.0"

  backend "s3" {
    bucket         = "aniket-tf-state-2025"         # change to your S3 bucket name
    key            = "jenkins-cicd/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"              # change to your DynamoDB table
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}
