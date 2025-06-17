## 🚀 Terraform ECS App Template
This repository provides a production-ready, fully modular infrastructure setup for AWS, written in Terraform.

It’s designed to deploy containerized applications using:

- Amazon ECS (Fargate)
- Application Load Balancer (ALB)
- Auto Scaling
- CloudWatch Alarms
- SNS Notifications
- ECR for Docker image storage
- Custom VPC + modular security


#### 📦 100% reusable — just change a few variables and you’re ready to launch your app.

## 📁 Modular structure
Each component is isolated in its own module:

```
modules/
├── alb/
├── autoscaling/
├── ecr/
├── ecs/
├── iam/
├── monitoring/
├── security-groups/
├── sns/
└── vpc/
```

## 📋 Requirements
- Terraform ≥ 1.4
- AWS CLI configured (aws configure)
- An active AWS account
- Permissions to create resources (VPC, ECS, IAM, ALB, CloudWatch, etc.)

## 🛠️ What does this template create?

- VPC across multiple availability zones
- Public and private subnets
- Internet Gateway and NAT Gateway
- ECS Cluster + Service + Task Definition
- Application Load Balancer + Target Group
- Auto scaling based on CPU and memory thresholds
- CloudWatch alarms + email notifications via SNS
- IAM roles and policies required for all services

## 🚀 Example usage

#### 🧪 How to deploy:

 1. Adapt the `envs/dev/main.tf` file for your proyect

```
terraform init
terraform plan
terraform apply
```


## 🧠 Included best practices:

- Full separation between infrastructure and application logic
- Uses variables.tf and outputs.tf in every module
- Centralized project naming with project_name
- Ready for dev, staging, and prod environments

## ✨ Want to contribute?

Pull requests, issues, and suggestions are more than welcome!
This project was built as a starter template for anyone who wants to learn or build scalable infrastructure in AWS.

## 🧑‍💻 Author
Built by **@thomaspinero00**