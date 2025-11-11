pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = AKIAUHLT6FP6LUXPGYUL('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = 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('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION     = 'ap-south-1'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Checking out repository...'
                git branch: 'main', url: 'https://github.com/anikettalwekar/jenkins-terraform-aws-cicd.git'
            }
        }

        stage('Terraform Init') {
            steps {
                echo 'Initializing Terraform...'
                sh '''
                    cd terraform
                    terraform init
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                echo 'Validating Terraform configuration...'
                sh '''
                    cd terraform
                    terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                echo 'Creating Terraform plan...'
                sh '''
                    cd terraform
                    terraform plan -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                echo 'Applying Terraform configuration...'
                sh '''
                    cd terraform
                    terraform apply -auto-approve tfplan
                '''
            }
        }

        stage('Terraform Destroy') {
            steps {
                input message: 'Confirm Terraform Destroy?', ok: 'Yes, Destroy'
                echo 'Destroying Terraform-managed infrastructure...'
                sh '''
                    cd terraform
                    terraform destroy -auto-approve
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline execution complete.'
        }
    }
}

