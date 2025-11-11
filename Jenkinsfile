pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID')
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "Ì≥¶ Checking out repository..."
                git branch: 'main', url: 'https://github.com/anikettalwekar/jenkins-terraform-aws-cicd.git'
            }
        }

        stage('Initialize Terraform') {
            steps {
                echo "‚öôÔ∏è Initializing Terraform..."
                sh 'cd terraform && terraform init'
            }
        }

        stage('Validate Terraform') {
            steps {
                echo "Ì∑© Validating Terraform code..."
                sh 'cd terraform && terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo "Ì≥ù Generating Terraform plan..."
                sh 'cd terraform && terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                echo "Ì∫Ä Applying Terraform changes..."
                sh 'cd terraform && terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        success {
            echo "‚úÖ Terraform apply completed successfully!"
        }
        failure {
            echo "‚ùå Build failed. Please check the Jenkins logs."
        }
    }
}
