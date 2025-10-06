#!/usr/bin/env bash
set -e

# =============================
# VARIÁVEIS DO AMBIENTE
# =============================
AWS_REGION="us-east-1"
ACCOUNT_ID="213899361839"
ECR_REPO_NAME="desafiokxc"
ECR_URI="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPO_NAME}"

echo "=== 🔧 Iniciando build da imagem Docker ==="
docker build -t ${ECR_REPO_NAME}:latest .

echo "=== 🔐 Fazendo login no Amazon ECR ==="
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

echo "=== 🏷️ Criando tag e preparando push ==="
docker tag ${ECR_REPO_NAME}:latest ${ECR_URI}:latest

echo "=== 🚀 Enviando imagem para o ECR ==="
docker push ${ECR_URI}:latest

echo "✅ Imagem enviada com sucesso para o ECR!"
echo "Repositório: ${ECR_URI}:latest"
