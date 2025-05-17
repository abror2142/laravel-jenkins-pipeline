pipeline {
  agent {
    label 'mac'
  }
  
  environment {
    // Change to your Docker Hub namespace/image
    IMAGE_NAME = 'abror2142/my-repo'
    // Derive a unique tag per build
    IMAGE_TAG  = "${env.BUILD_NUMBER}"
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
              php artisan key:generate
            '''
          }
        }

        stage('Build Frontend assets') {
          steps {
            sh '''
              cd app
              npm ci
              npm run build
            '''
          }
        }

      }
    }

    stage('Preparing database') {
      steps {
        sh '''
          cd app
          mkdir -p database
          touch database/database.sqlite
          php artisan migrate:fresh --seed
        '''
      }
    }

    stage('Test') {
      steps {
        sh '''
          cd app
          php artisan test
        '''
      }
    }

    stage('Docker Login') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'docker-hub-pat',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          // Use --password-stdin to avoid needing a TTY
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
          '''
        }
      }
    }

    stage('Docker build') {
      steps {
        sh '''
          docker build -f app/Dockerfile . -t abror2142/my-repo:latest
        '''
      }
    }

    stage('Docker push') {
      steps {
        sh '''
          docker push abror2142/my-repo:latest
        '''
      }
    }
  }
}