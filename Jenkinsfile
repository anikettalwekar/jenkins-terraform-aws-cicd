pipeline {
    agent any

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
            steps {
                input message: 'Confirm Terraform Destroy?', ok: 'Yes, Destroy'
                echo 'Destroying Terraform-managed infrastructure...'
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
            echo 'Pipeline execution complete.'
        }
    }
}

