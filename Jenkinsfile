pipeline {
agent any
environment { DOCKER_TAG = getVersion()}
stages {
stage ('Clone Stage') {
steps {
git https://gitlab.com/jmlhmd/datacamp_docker_angular.git'
}
}
}
