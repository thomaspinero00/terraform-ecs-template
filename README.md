## 🚀 Terraform ECS App Template
This repository provides a production-ready, fully modular infrastructure setup for AWS, written in Terraform.

It’s designed to deploy containerized applications using:

- Amazon ECS (Fargate)
- Application Load Balancer (ALB)
- Auto Scaling
- CloudWatch Alarms
- SNS Notifications
- Docker image (public)
- Custom VPC + modular security


#### 📦 100% reusable — just change a few variables and you’re ready to launch your app.

## 📁 Modular structure
Each component is isolated in its own fully reusable and adaptable module:

```
modules/
├── alb_base/
├── alb_listeners/
├── autoscaling/
├── ecs/
├── iam/
├── monitoring/
├── route53_acm/
└── security-groups/
├── sns/
├── vpc/
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



## 🚀 How to Use

Follow these steps to launch your ECS app on AWS:

### 1. Clone this repository
```bash
git clone https://github.com/thomaspinero00/terraform-ecs-template.git
cd terraform-ecs-template
```

### 2. Configure the remote backend (state management)
```bash
cd remote-state
terraform init
terraform apply
```

> ⚠️ If the apply fails because the S3 bucket name is already taken, update the name in `main.tf` and `/envs/dev/backend.tf` and try again.

### 3. Move to your environment folder
```bash
cd ../envs/dev
```

### 4. Edit your `terraform.tfvars`
Set the project name, domain, subdomain, and other configuration in `terraform.tfvars`.

> ⚠️ The `project_name` must be unique to avoid naming conflicts in AWS.

### 5. Deploy the infrastructure
```bash
terraform init
terraform apply
```

### 6. Push a dummy image to ECR (first-time setup)
After the infrastructure is created, your private ECR repository will be empty.

To ensure ECS can start your app without errors, run the provided script to upload a placeholder (dummy) image:

```
bash scripts/push_dummy_image.sh
```

> This script logs in to ECR, pulls a lightweight public image (`nginx:alpine`), tags it, and pushes it to your new ECR repository as latest.

You can replace this image later with your own app image—see the documentation for more details.


### 7. Modify your nameservers on your DNS Provider
During the execution of the `terraform apply` command, you would need to change the `nameservers` on your DNS provider.

If you need guidance to make this step, follow the guide.
[How to get nameservers from aws cli](./guide_to_get_nameservers.md).


### ✅ That’s it!
After a few minutes, your entire infrastructure will be live — including HTTPS, DNS, auto scaling, ECS, monitoring, and more.

The final app URL will be printed in the `app_url` output. You can now point your DNS (e.g. GoDaddy) to the provided Route53 nameservers.


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