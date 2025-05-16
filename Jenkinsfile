pipeline {
  agent {
    docker {
      image 'composer:2'
      args  '-u root'       
    }
  }
  stages {
    stage('Checkout') {
      steps {
        git(url: 'https://github.com/abror2142/laravel-jenkins-pipeline', branch: 'main')
      }
    }

    stage('Test backend') {
      steps {
        sh 'ls app'
        sh 'cd app'
        sh 'composer require'
        sh 'php artisan test'
      }
    }

  }
}