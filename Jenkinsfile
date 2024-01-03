pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhubcredentials')
    PROJECT_ID = 'cobalt-compound-408209'
    CLUSTER_NAME = 'cobalt-compound-408209-gke'
    LOCATION = 'us-east1'
    CREDENTIALS_ID = 'kubernetes'
  }
  stages {
      stage('Github Trigger jenkins') {
      steps {
        checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/satish-shrote/nodeapp']])
      }
    }
    stage('Build') {
      steps {
        sh 'docker build -t liligogo/nodeapp:$BUILD_NUMBER .'
        echo 'Build Image Completed'  
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
        echo 'Login Completed'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push liligogo/nodeapp:$BUILD_NUMBER'
        echo 'Push Image Completed' 
      }
    }
    stage('Deploy to GKE') { 
      steps{ 
        echo "Deployment started ..."
        sh 'ls -ltr'
        sh 'pwd'
        sh "sed -i 's/nodeapp:$BUILD_NUMBER/g' nodeapp-depl.yaml"
                   step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'nodeapp-depl.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
        echo "Deployment Finished ..."
            }
        }
    }
}
