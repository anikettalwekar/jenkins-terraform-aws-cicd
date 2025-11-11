pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = AKIAUHLT6FP6LUXPGYUL('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = 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('AWS_SECRET_ACCESS_KEY')
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo '📦 Checking out repository...'
                git branch: 'main', url: 'https://github.com/anikettalwekar/jenkins-terraform-aws-cicd.git'
            }
        }

        stage('Terraform Init') {
            steps {
                echo '⚙️ Initializing Terraform...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID']]) {
                    sh '''
                        cd terraform
                        terraform init
                    '''
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                echo '🧩 Validating Terraform...'
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
                echo '📝 Planning Terraform...'
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
                echo '🚀 Applying Terraform...'
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_ACCESS_KEY_ID']]) {
                    sh '''
                        cd terraform
                        terraform apply -auto-approve tfplan
                    '''
                }
            }
        }

        // ✅ Added Destroy stage correctly inside stages block
        stage('Terraform Destroy') {
            steps {
                echo '🧹 Destroying Terraform-managed infrastructure...'
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
        always {
            echo '✅ Pipeline finished — cleanup complete.'
        }
    }
}


