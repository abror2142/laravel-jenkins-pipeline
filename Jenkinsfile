pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git(url: 'https://github.com/abror2142/laravel-jenkins-pipeline', branch: 'main')
      }
    }

    stage('List') {
      steps {
        sh 'ls -la'
      }
    }

  }
}