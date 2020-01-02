pipeline {
  agent any
  stages {
    stage('Build') {
      agent any
      environment {
        FUCK = 'sahamra'
      }
      steps {
        echo 'Hello Guys'
        mail(subject: 'lala', body: 'its done', from: 'haha', to: 'sameeraksc@gmail.com')
        echo 'Build is Done.'
      }
    }

    stage('Test') {
      steps {
        echo 'This is testing'
      }
    }

    stage('Deploy') {
      steps {
        echo 'H ha hari hawa'
      }
    }

  }
}