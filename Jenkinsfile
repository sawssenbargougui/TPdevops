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
                sh 'docker build -t jmlhmd/image_name:${DOCKER_TAG} .'
               // sh 'docker run -d -p 8888:80 jmlhmd/image_name:${DOCKER_TAG}'
            }
        }
        stage ('DockerHub Push') {
            steps {
            
        withCredentials([string(credentialsId: '68095310-5de9-4e44-bc26-90034a3261cf', variable: 'DockerPWD')]) {
                 sh 'docker login -u jmlhmd -p ${DockerPWD}'
            }
                sh 'docker push jmlhmd/image_name:${DOCKER_TAG}'
            }
        }
        stage ('Deploy') {
            steps{
               sshagent(credentials: ['Vagrant_ssh']) { 
                  //  sh "ssh -tt jenkins@192.168.1.144"
                    //sh "scp target/hello-world-app-1.0-SNAPSHOT.jar vagrant@10.40.31.201:/home/vagrant"
                    sh "ssh vagrant@192.168.1.101 'docker run -d -p 8888:80 jmlhmd/image_name:${DOCKER_TAG}'"
                
            }
            }
        }
    }
}
def getVersion(){
    def version = sh returnStdout: true, script: 'git rev-parse --short HEAD'
    return version
}
