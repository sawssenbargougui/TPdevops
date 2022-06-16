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
            }
        }
        stage ('DockerHub Push') {
            steps {
                withCredentials([string(credentialsId: '454ae11c-3164-41a0-a219-294a7d78c8ce', variable: 'password_dockerhub')]) {
                    sh 'sudo docker login -u jmlhmd -p ${password_dockerhub}'
                }
                sh 'sudo docker push jmlhmd/image_name:${DOCKER_TAG}'
            }
        }
        stage ('Deploy') {
            steps{
                sshagent(credentials: ['Vagrant_ssh']) {
                sh "ssh vagrant@192.168.1.201"
                //sh "scp target/hello-world-app-1.0-SNAPSHOT.jar vagrant@192.168.1.201:/home/vagrant"
                sh "ssh vagrant@192.168.1.201 'sudo docker run "image_name:${DOCKER_TAG}"'"
                }
            }
}    
    }
}
def getVersion(){
    def version = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return version
}
