pipeline {
    agent any

    parameters {
        string(name: 'ENV', defaultValue: 'prod', description: 'Environment')
    }

    stages {

        stage('Terraform Apply') {
            steps {
                sh 'make ${ENV}'
            }
        }
    }
}