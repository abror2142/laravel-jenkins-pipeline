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
        withCredentials(bindings: [usernamePassword(
                                                                                credentialsId: 'docker-hub-pat',
                                                                                usernameVariable: 'DOCKER_USER',
                                                                                passwordVariable: 'DOCKER_PASS'
                                                                              )]) {
            sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
          '''
          }

        }
      }

      stage('Docker build') {
        steps {
          sh '''
          sudo docker build -f php/Dockerfile -t abror2142/my-repo:latest .

          sudo docker tag abror2142/my-repo:latest abror2142/my-repo:v1.0.0
           '''
        }
      }

      stage('Docker push') {
        steps {
          sh '''
          sudo docker push abror2142/my-repo:v1.0.0
        '''
        }
      }

    }
    environment {
      IMAGE_NAME = 'abror2142/my-repo'
      IMAGE_TAG = "${env.BUILD_NUMBER}"
    }
  }