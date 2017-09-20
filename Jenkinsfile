pipeline {
  agent any
  environment {
    DEPLOY_ENV = "staging"
    REPOSITORY = "472554934874.dkr.ecr.us-east-1.amazonaws.com/quake-relief-cdmx"
    TAG = "v_${env.BUILD_NUMBER}"
    HOST = "deploy@quake-relief-cdmx.civicadesarrolla.me"
    COMPOSE_PROJECT_NAME = "quake-relief-cdmx"
  }
  stages {
    stage('Bundle') {
      steps {
        sh 'make bundle'
      }
    }
    stage('Deploy') {
      when {
        branch 'master'
      }
      steps {
        sh 'make deploy'
      }
    }
    stage('Clean') {
      steps {
        sh 'make clean'
      }
    }
  }
}
