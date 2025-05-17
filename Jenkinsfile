pipeline {
  agent {
    label 'mac'
  }
  stages {
    stage('Checkout') {
      steps {
        git(url: 'https://github.com/abror2142/laravel-jenkins-pipeline', branch: 'main')
      }
    }

    stage('Prepare environment') {
      steps {
        sh '''
          cd app
          mv .env.example .env
          composer require
          php artisan key:generate'''
      }
    }

  }
}