pipeline {
agent any 

```
envirnment {
    AWS_REGION = "ap-south-1"
    ECR_REPO = "873540495696.dkr.ecr.ap-south-1.amazonaws.com/cicd-app"
    IMAGE_TAG = "latest"
}

stages {

    stage('Clone') {
        steps {
            git 'https://github.com/imrohit9148/devops-cicd-project.git'
        }
    }

    stage('Build Image') {
        steps {
            sh 'docker build -t cicd-app .'
        }
    }

    stage('Tag Image') {
        steps {
            sh 'docker tag cicd-app:latest $ECR_REPO:$IMAGE_TAG'
        }
    }

    stage('Login to ECR') {
        steps {
            sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin 873540495696.dkr.ecr.ap-south-1.amazonaws.com'
        }
    }

    stage('Push Image') {
        steps {
            sh 'docker push $ECR_REPO:$IMAGE_TAG'
        }
    }

    stage('Deploy to K8s') {
        steps {
            sh 'kubectl rollout restart deployment cicd-app'
        }
    }
}
```

}

