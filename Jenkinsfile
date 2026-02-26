pipeline {
    agent any

    environment {
        ECR_REPO = "873540495696.dkr.ecr.ap-south-1.amazonaws.com/cicd-app"
        AWS_REGION = "ap-south-1"
    }

    stages {

        stage('Build Docker') {
            steps {
                sh 'docker build -t cicd-app .'
            }
        }

        stage('Tag Image') {
            steps {
                sh 'docker tag cicd-app:${BUILD_NUMBER} $ECR_REPO:latest'
            }
        }

        stage('Push ECR') {
            steps {
                sh '''
                aws ecr get-login-password --region $AWS_REGION | \
                docker login --username AWS --password-stdin 873540495696.dkr.ecr.ap-south-1.amazonaws.com
                docker push $ECR_REPO:latest
                '''
            }
        }

        stage('Deploy K8s') {
            steps {
		sh 'kubectl apply -f k8s/deploy.yaml'
		sh 'kubectl apply -f k8s/deploy.yaml'
		sh 'kubectl rollout restart deployment cicd-app'	
            }
        }
    }
}
