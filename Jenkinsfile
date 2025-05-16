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

    stage('Test backend') {
      steps {
        sh '''
          cd app
          /opt/homebrew/bin/composer require
          php artisan test
        '''
      }
    }

  }
}