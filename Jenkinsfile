pipeline {
    agent any

    environment {
        ECR_REPO = "873540495696.dkr.ecr.ap-south-1.amazonaws.com/cicd-app"
        AWS_REGION = "ap-south-1"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {

        stage('Build Docker') {
            steps {
                sh 'docker build -t cicd-app:${IMAGE_TAG} .'
            }
        }

        stage('Tag Image') {
            steps {
                sh '''
                docker tag cicd-app:${IMAGE_TAG} $ECR_REPO:${IMAGE_TAG}
                docker tag cicd-app:${IMAGE_TAG} $ECR_REPO:latest
                '''
            }
        }

        stage('Push ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin 873540495696.dkr.ecr.ap-south-1.amazonaws.com

                docker push $ECR_REPO:${IMAGE_TAG}
                docker push $ECR_REPO:latest
                '''
            }
        }

        stage('Deploy K8s') {
            steps {
                sh '''
                kubectl set image deployment/cicd-app cicd-app=$ECR_REPO:${IMAGE_TAG}
                kubectl rollout status deployment cicd-app
                '''
            }
        }
    }
}
