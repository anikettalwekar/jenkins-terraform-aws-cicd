pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = AKIAUHLT6FP6LUXPGYUL('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = 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('AWS_ACCESS_KEY_ID')
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "��� Checking out repository..."
                git branch: 'main', url: 'https://github.com/anikettalwekar/jenkins-terraform-aws-cicd.git'
            }
        }

        stage('Initialize Terraform') {
            steps {
                echo "⚙️ Initializing Terraform..."
                sh 'cd terraform && terraform init'
            }
        }

        stage('Validate Terraform') {
            steps {
                echo "��� Validating Terraform code..."
                sh 'cd terraform && terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                echo "��� Generating Terraform plan..."
                sh 'cd terraform && terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                echo "��� Applying Terraform changes..."
                sh 'cd terraform && terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        success {
            echo "✅ Terraform apply completed successfully!"
        }
        failure {
            echo "❌ Build failed. Please check the Jenkins logs."
        }
    }
}
