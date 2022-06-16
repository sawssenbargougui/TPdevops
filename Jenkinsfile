pipeline {
    agent any
    environment {
        DOCKER_TAG = getVersion()
    }
    stages {
        stage ('Clone Stage') {
            steps { git 'https://gitlab.com/jmlhmd/datacamp_docker_angular.git'}*
            sh echo $DOCKER_TAG
        }
    }
}
def getVersion(){
    def version = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return version
}
