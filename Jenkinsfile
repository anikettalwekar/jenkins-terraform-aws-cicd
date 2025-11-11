pipeline {
    agent any

    environment {
        AWS_REGION = "ap-south-1"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Checking out public GitHub repository...'
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/anikettalwekar/jenkins-terraform-aws-cicd.git'
                    ]]
                ])
            }
        }

        stage('Verify AWS Credentials') {
            steps {
                echo 'Verifying AWS credentials before running Terraform...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID']]) {
                    sh 'aws sts get-caller-identity'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                echo 'Initializing Terraform with S3 backend...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID']]) {
                    sh '''
                        cd terraform
                        terraform init -backend-config="bucket=infra-terraform-state-aniket-2025" \
                                       -backend-config="key=terraform/state.tfstate" \
                                       -backend-config="region=ap-south-1"
                    '''
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                echo 'Validating Terraform configuration...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID']]) {
                    sh '''
                        cd terraform
                        terraform validate
                    '''
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                echo 'Creating Terraform plan...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID']]) {
                    sh '''
                        cd terraform
                        terraform plan -out=tfplan
                    '''
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                echo 'Applying Terraform configuration...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID']]) {
                    sh '''
                        cd terraform
                        terraform apply -auto-approve tfplan
                    '''
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { return params.DESTROY == true }
            }
            steps {
                echo 'Destroying Terraform resources...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID']]) {
                    sh '''
                        cd terraform
                        terraform destroy -auto-approve
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform pipeline executed successfully!'
        }
        failure {
            echo 'Pipeline failed. Check the console output.'
        }
    }
}

