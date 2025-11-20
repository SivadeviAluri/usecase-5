pipeline {  
    agent any  
    environment {  
        DOCKERHUB_CREDENTIALS = credentials('hello')  
    }  
    stages {  
        stage('checkout') {  
            steps {  
                echo "*********** cloning the code **********"  
                sh 'rm -rf usecase-5 || true'  
                sh 'git clone https://github.com/SivadeviAluri/usecase-5.git' 
            }  
        }   
        stage('Docker image build') {  
            steps {  
                echo "********** building is done ************"  
                dir('usecase-5') {  
                    sh 'docker build -t devi819/flask1:v1 .'  
                }  
            }  
        }
        stage('Push to Docker Hub') {  
            steps {  
                sh """  
                docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}  
                docker push devi819/flask1:v1  
                """  
            }  
        }
        stage('vm creation using Terraform') {
            steps {
                echo "********** VM creation is done ************"
                dir('usecase-5') {
                    sh 'git pull origin main'
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        stage('Ansible deployment') {
            steps {
                echo "********** Ansible deployment is done ************"
                dir('usecase-5') {
                    sh 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /var/lib/jenkins/workspace/ip.txt playbook.yaml --private-key=/var/lib/jenkins/.ssh/id_ed25519 '
                }
            }
        }
    }  
}
