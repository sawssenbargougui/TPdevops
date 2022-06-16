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
                sh 'sudo docker run -d -p 8888:80 jmlhmd/image_name:${DOCKER_TAG}'
            }
        }
        stage ('DockerHub Push') {
            steps {
                withCredentials([string(credentialsId: 'mydockerhubpassword', variable: 'DockerHubPassword')]) {
                sh 'sudo docker login -u jmlhmd -p ${DockerHubPassword}'
                }
                sh 'sudo docker push jmlhmd/image_name:${DOCKER_TAG}'
            }
        }
        stage ('Deploy') {
            steps{
                sshagent(credentials: ['Vagrant_ssh']) {
                    sh "ssh vagrant@192.168.1.201"
                    //sh "scp target/hello-world-app-1.0-SNAPSHOT.jar vagrant@192.168.1.201:/home/vagrant"
                    sh "ssh vagrant@192.168.1.201 'sudo docker run -d -p 8888:80 jmlhmd/image_name:${DOCKER_TAG}'"
                }
            }
        }
    }
}
def getVersion(){
    def version = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return version
}
