#!/bin/bash

# ------------- CONFIG -------------
AWS_REGION="us-east-1"            # Set your region if different
REPO_NAME="myappv2testing-repo"           # Set this to match your ECR repo name (should match your Terraform config)
IMAGE_TAG="latest"                # Usually "latest" for initial deploy
# ----------------------------------

# Get AWS Account ID
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

if [[ -z "$ACCOUNT_ID" ]]; then
  echo "❌ Could not retrieve AWS Account ID. Is your AWS CLI configured correctly?"
  exit 1
fi

echo "🪪 AWS Account ID: $ACCOUNT_ID"
echo "📦 ECR Repo Name: $REPO_NAME"
echo "🌎 AWS Region: $AWS_REGION"
echo "🏷️ Image Tag: $IMAGE_TAG"
echo

# Login to ECR
echo "🔑 Logging in to ECR..."
aws ecr get-login-password --region $AWS_REGION | \
  docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

if [[ $? -ne 0 ]]; then
  echo "❌ ECR login failed."
  exit 1
fi

# Pull & tag dummy image (nginx:alpine)
echo "⬇️ Pulling dummy image (nginx:alpine)..."
docker pull nginx:alpine

echo "🏷️ Tagging image for your ECR..."
docker tag nginx:alpine $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:$IMAGE_TAG

# Push to ECR repo
echo "🚀 Pushing dummy image to ECR..."
docker push $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:$IMAGE_TAG

if [[ $? -eq 0 ]]; then
  echo "✅ Dummy image pushed successfully to ECR!"
  echo "    $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPO_NAME:$IMAGE_TAG"
else
  echo "❌ Failed to push the image to ECR. Check the logs above."
  exit 1
fi
