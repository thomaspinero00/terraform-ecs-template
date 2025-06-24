module "vpc" {
  project_name    = var.project_name
  source          = "../../modules/vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  azs             = var.azs
}

module "iam" {
  project_name = var.project_name
  source       = "../../modules/iam"
}

module "security_groups" {
  project_name = var.project_name

  source = "../../modules/security-groups"
  vpc_id = module.vpc.vpc_id
}




module "alb_base" {
  source            = "../../modules/alb_base"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
}

module "route53_acm" {
  source       = "../../modules/route53_acm"
  project_name = var.project_name
  domain_name  = var.domain_name
  subdomain    = var.subdomain
  alb_dns_name = module.alb_base.alb_dns_name
  alb_zone_id  = module.alb_base.alb_zone_id
}


module "alb_listeners" {
  source           = "../../modules/alb_listeners"
  alb_arn          = module.alb_base.alb_arn
  target_group_arn = module.alb_base.target_group_arn
  certificate_arn  = module.route53_acm.certificate_arn
}


module "ecr" {
  source       = "../../modules/ecr"
  project_name = var.project_name
}


module "ecs" {
  project_name            = var.project_name
  source                  = "../../modules/ecs"
  cluster_name            = var.cluster_name
  container_image         = "${module.ecr.repository_url}:latest"
  task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  subnet_ids              = module.vpc.private_subnet_ids
  security_group_ids      = [module.security_groups.ecs_sg_id]
  desired_count           = var.desired_count
  target_group_arn        = module.alb_base.target_group_arn
  listener_dependency     = module.alb_listeners.https_listener_arn

}

module "autoscaling" {
  project_name     = var.project_name
  source           = "../../modules/autoscaling"
  ecs_cluster_name = module.ecs.cluster_name
  ecs_service_name = module.ecs.service_name
  min_capacity     =  var.min_capacity
  max_capacity     =  var.max_capacity
}

module "sns" {
  project_name = var.project_name
  source       = "../../modules/sns"
  emails = var.emails
}

module "monitoring" {
  project_name          = var.project_name
  source                = "../../modules/monitoring"
  ecs_cluster_name      = module.ecs.cluster_name
  ecs_service_name      = module.ecs.service_name
  high_cpu_threshold    = var.high_cpu_threshold
  low_cpu_threshold     = var.low_cpu_threshold
  high_memory_threshold = var.high_memory_threshold
  low_memory_threshold  = var.low_memory_threshold
  high_cpu_actions      = [module.autoscaling.scale_up_policy_arn]
  low_cpu_actions       = [module.autoscaling.scale_down_policy_arn]
  high_memory_actions   = [module.autoscaling.scale_up_policy_arn]
  low_memory_actions    = [module.autoscaling.scale_down_policy_arn]
  notification_actions  = [module.sns.sns_topic_arn]
}

