Jenkins Terraform AWS CI/CD Project
Project Overview

This project demonstrates how to automate AWS infrastructure deployment using Jenkins and Terraform.
The pipeline pulls Terraform code from GitHub, initializes and validates the configuration, and provisions AWS resources such as VPC, subnet, security group, and EC2 instance.

Architecture
Source Code: GitHub Repository
CI/CD Tool: Jenkins
Infrastructure as Code: Terraform
Cloud Provider: AWS
State Management: AWS S3 Bucket

Workflow:
GitHub → Jenkins → Terraform → AWS

AWS Resources Created
1 VPC – infra-project-vpc
1 Subnet – infra-project-subnet
1 Security Group – infra-project-sg
1 EC2 Instance – infra-project-ec2

Prerequisites
AWS Account
IAM User with permissions:
              AmazonS3FullAccess
              AdministratorAccess

S3 bucket for Terraform state (example: infra-terraform-state-aniket-2025)
EC2 instance with Jenkins and Terraform installed
SSH key pair (example: account-a)

Jenkins Configuration
  Install the following plugins:
    AWS Credentials
    Terraform
    Git
    Pipeline

Add AWS credentials in Jenkins:
    Go to Manage Jenkins → Manage Credentials → Global
    Add AWS Credentials with ID: AWS_ACCESS_KEY_ID

Create a pipeline job and use the GitHub repository URL: https://github.com/anikettalwekar/jenkins-terraform-aws-cicd.git

Jenkinsfile handles all Terraform operations:
    Initialize
    Validate
    Plan
    Apply
    Destroy (optional)

Terraform Files
    main.tf – Defines AWS resources (VPC, subnet, EC2, security group)
    variables.tf – Declares variable inputs (e.g., key name)
    outputs.tf – Displays output values like instance ID and public IP
    provider.tf – Configures AWS provider and backend (S3)

Pipeline Stages
    Checkout Code
    Verify AWS Credentials
    Terraform Init
    Terraform Validate
    Terraform Plan
    Terraform Apply
    Terraform Destroy (optional)


Verification
    After successful pipeline execution:
    AWS Console shows new EC2, VPC, and subnet resources.
    The Terraform state file is stored in the S3 bucket.
    Console output in Jenkins confirms each step.

Clean-Up
    To remove all infrastructure: terraform destroy -auto-approve

Conclusion
This project demonstrates a complete CI/CD pipeline for automating AWS infrastructure deployment using Jenkins and Terraform.
It integrates version control, automation, and infrastructure management, showcasing a modern DevOps workflow.
