terraform {
  backend "s3" {
    bucket         = "aniket-tf-state-2025"
    key            = "jenkins-cicd/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

