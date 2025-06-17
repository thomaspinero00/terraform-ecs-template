module "vpc" {
  project_name = "my-awesome-app"
  source          = "../../modules/vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  azs             = ["us-east-1a", "us-east-1b"] #Adapt here for your case
}

module "iam" {
  project_name = "my-awesome-app"
  source = "../../modules/iam"
}

module "security_groups" {
  project_name = "my-awesome-app"
  source = "../../modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  project_name = "my-awesome-app"
  source            = "../../modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
}

module "ecs" {
  project_name = "my-awesome-app"
  source                  = "../../modules/ecs"
  cluster_name            = "my-awesome-app-cluster"
  container_image         = "nginx:latest"
  task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  subnet_ids              = module.vpc.private_subnet_ids
  security_group_ids      = [module.security_groups.ecs_sg_id]
  desired_count           = 1
  target_group_arn        = module.alb.target_group_arn
}

module "autoscaling" {
  project_name = "my-awesome-app"
  source           = "../../modules/autoscaling"
  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
  min_capacity     = 1
  max_capacity     = 3
}

module "sns" {
  project_name = "my-awesome-app"
  source = "../../modules/sns"
  emails = [
    "example@example.com", # SNS will notify this list if the system scales up or down
    #NOTE: The email must accept the subcriptions for this to work properly.
  ]
}

module "monitoring" {
  project_name = "my-awesome-app"
  source                = "../../modules/monitoring"
  ecs_cluster_name      = module.ecs.cluster_name
  ecs_service_name      = module.ecs.service_name
  high_cpu_threshold    = 50
  low_cpu_threshold     = 5
  high_memory_threshold = 50
  low_memory_threshold  = 5
  high_cpu_actions      = [module.autoscaling.scale_up_policy_arn]
  low_cpu_actions       = [module.autoscaling.scale_down_policy_arn]
  high_memory_actions   = [module.autoscaling.scale_up_policy_arn]
  low_memory_actions    = [module.autoscaling.scale_down_policy_arn]
  notification_actions  = [module.sns.sns_topic_arn]
}
