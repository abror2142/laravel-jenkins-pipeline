pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git(url: 'https://github.com/abror2142/laravel-jenkins-pipeline', branch: 'main')
      }
    }

    stage('Test backend') {
      steps {
        sh 'ls app'
        sh '''composer require
php artisan test'''
      }
    }

  }
}