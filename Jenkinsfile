pipeline {
  agent { label 'mac' }

  environment {
    IMAGE      = 'abror2142/my-repo'
    IMAGE_TAG  = 'latest'
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/abror2142/laravel-jenkins-pipeline.git',
            branch: 'main',
            credentialsId: 'github-pat'
      }
    }

    stage('Prepare environment') {
      parallel {
        stage('Backend') {
          steps {
            dir('app') {
              sh '''
                cp .env.example .env
                composer install --no-interaction --prefer-dist
                php artisan key:generate
              '''
            }
          }
        }
        stage('Frontend') {
          steps {
            dir('app') {
              sh '''
                npm ci
                npm run build
              '''
            }
          }
        }
      }
    }

    stage('Database') {
      steps {
        dir('app') {
          sh '''
            mkdir -p database
            touch database/database.sqlite
            php artisan migrate:fresh --seed --env=testing
          '''
        }
      }
    }

    stage('Test') {
      steps {
        dir('app') {
          sh 'php artisan test --env=testing --verbose'
        }
      }
    }

    stage('Docker Build') {
      steps {
        // no sudo—make sure jenkins user is in docker group
        sh 'docker build -f php/Dockerfile -t $IMAGE:$IMAGE_TAG .'
      }
    }

    stage('Docker Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'docker-hub-pat',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
            docker push $IMAGE:$IMAGE_TAG
          '''
        }
      }
    }
  }

  post {
    success { echo "✅ Successfully built & pushed $IMAGE:$IMAGE_TAG" }
    failure { echo "❌ Build or push failed" }
  }
}
