pipeline {
    agent any
    environment {
        DOCKER_TAG = getVersion()
    }
    stages {
        stage ('Clone Stage') {
            steps { 
                git 'https://gitlab.com/jmlhmd/datacamp_docker_angular.git'
                sh 'echo $DOCKER_TAG'
            }
        }
        stage ('Docker Build') {
            steps {
                sh 'sudo docker build -t jmlhmd/image_name:${DOCKER_TAG} .'
                sh 'sudo docker run -p 8888:80 jmlhmd/image_name:${DOCKER_TAG}'
            }
        }
   
    }
}
def getVersion(){
    def version = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return version
}
