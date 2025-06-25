pipeline {
    agent any // 可以在任何可用的 Jenkins 代理上运行

    environment {
        // 定义前端构建目录和目标部署目录
        FRONTEND_BUILD_DIR = 'build' // 假设你的前端构建产物在项目根目录下的 'build' 文件夹
        NGINX_FRONTEND_PATH = '/usr/share/nginx/html/your-frontend-app' // Nginx 托管前端的目录
    }
  
    stages {
        stage('Checkout Frontend Code') {
            steps {
                git branch: 'main', url: 'https://github.com/anangxu/movie-frontend-docker' // 替换为你的前端 Git 仓库地址和分支
            }
        }

        stage('Build Frontend') {
            steps {
                // 如果使用 NodeJS Plugin，可以这样配置 Node 环境
                // tool name: 'Node.js 18.x', type: 'nodejs'
                // sh 'npm install'
                // sh 'npm run build'

                // 或者直接使用系统中已安装的 Node.js
                sh '''
                    echo "Installing Node.js dependencies..."
                    npm install --legacy-peer-deps
                    echo "Building frontend application..."
                    npm run build
                '''
            }
        }

        stage('Deploy Frontend to Nginx') {
            steps {
                // 清理旧的前端文件
                sh "sudo rm -rf ${NGINX_FRONTEND_PATH}/*"
                // 复制新的构建产物到 Nginx 目录
                sh "sudo cp -r ${FRONTEND_BUILD_DIR}/* ${NGINX_FRONTEND_PATH}/"
                // 确保 Nginx 用户有权限访问这些文件（根据实际情况调整）
                sh "sudo chown -R nginx:nginx ${NGINX_FRONTEND_PATH}"
                echo "Frontend deployed to Nginx at ${NGINX_FRONTEND_PATH}"

                // 刷新 Nginx 配置或重启 Nginx (如果 Nginx 配置有变，通常不需要)
                // sh 'sudo systemctl reload nginx'
            }
        }
    }

    post {
        always {
            // 清理工作区 (可选，但推荐)
            sh 'sudo rm -rf target build node_modules || true'
        }
        success {
            echo 'Frontend Pipeline Finished Successfully!'
        }
        failure {
            echo 'Frontend Pipeline Failed!'
        }
    }
}