#!groovy

node {

  currentBuild.result = "SUCCESS"

    try {

      // checkout the git repo
      stage ('Checkout') {
        checkout scm
      }

      // First stage, set the credentials
      stage ('Set credentials') {
        ansiColor('xterm') {
          sh "sed -i -e 's/_USERNAME_/${env.USERNAME}/g' security.groovy"
          sh "sed -i -e 's/_PASSWORD_/${env.PASSWORD}/g' security.groovy"
        }
      }
  
      // Build the container 
      stage ('Build container') {
        ansiColor('xterm') {
          sh 'docker build --build-arg GID=$(grep docker /etc/group | cut -d: -f3) -t jenkins:latest .'
        }
      }
  
      // Tag the container
      stage ('Tag container') {
        ansiColor('xterm') {
          sh 'docker tag jenkins:latest maxstack/jenkins:latest'
        }
      }
  
      // Push the container to dockerhub
      // assumes you have run docker login as the jenkins user on your host
      stage ('Push container') {
        ansiColor('xterm') {
          sh 'docker push registry maxstack/jenkins:latest'
        }
      }

      // cleanup the workspace after each run
      cleanWs()
    }
    catch (err) {

      currentBuild.result = 'FAILURE'
      throw err
    }
}
