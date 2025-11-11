provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "aniket-tf-state-2025"
    key            = "jenkins-cicd/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
  }
}


