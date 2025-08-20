pipeline{
    agent any
    options {
        buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '30', numToKeepStr: '5')
    }
    tools {
        maven 'Maven-3.8.7'
    }

    environment{
        cred = credentials('k8s-server-key')
        dockerhub_cred = credentials('dockerhub-creds')
        DOCKER_IMAGE = "htyagi2233/simple-webapp"
        DOCKER_TAG = "$BUILD_NUMBER"
		 KUBECONFIG = "${WORKSPACE}/kubeconfig" //optional to upload kubeconfig file
    }
    stages{
        stage('Checkout Stage'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/htyagi2233/simple-webapp.git']])
            }
        }
        stage('Maven Stage'){
            steps{
                sh 'mvn package'
            }
        }
        stage('Docker Build'){
            steps{
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }
        stage('Docker Push'){
            steps{
                sh "echo $dockerhub_cred_PSW | docker login -u $dockerhub_cred_USR --password-stdin"
                sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"   //renameing the tag
                sh "docker push ${DOCKER_IMAGE}:latest"
            }
        }
		
        // stage('Copy Kubeconfig') {
		//     steps {
		//         withCredentials([file(credentialsId: 'kubeconfig-onprem', variable: 'KUBECONFIG_FILE')]) {
		//             sh 'cp $KUBECONFIG_FILE kubeconfig'
		//         }
		//     }
        // }

        stage('K8s Deploy'){
            steps{
                sh 'kubectl apply -f deployment.yaml'
                sh 'kubectl get svc,deploy,pod'
            }
        }
    }
    post {
      always {
        echo 'Pipeline completed !'
      }
      success {
        echo 'Pipeline completed successfully!'
      }
      failure {
        echo 'Pipeline failed!'
      }
}

}