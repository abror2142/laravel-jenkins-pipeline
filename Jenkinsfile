pipeline {
  agent {
    label 'mac'
  }
  stages {
    stage('Checkout') {
      steps {
        git(url: 'https://github.com/abror2142/laravel-jenkins-pipeline', branch: 'main', credentialsId: 'github-pat')
      }
    }

    stage('Prepare environment') {
      parallel {
        stage('Backend environment') {
          steps {
            sh '''
          cd app
          mv .env.example .env
          composer require
          php artisan key:generate'''
          }
        }

        stage('Build Frontend assets') {
          steps {
            sh '''cd app
npm ci
npm run build'''
          }
        }

      }
    }

    stage('Preparing database') {
      steps {
        sh '''cd app
mkdir -p database
touch database/database.sqlite
php artisan migrate:fresh --seed'''
      }
    }

    stage('Test') {
      steps {
        sh '''cd app
php artisan test'''
      }
    }

    stage('DokerHub') {
      steps {
        sh 'docker login '
      }
    }

  }
}