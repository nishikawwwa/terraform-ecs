module "alb" {
  source  = "./Modules/ALB"
  name    = var.name
  subnets = var.subnets
  vpc_id  = var.vpc_id
}

module "ecs" {
  source            = "./Modules/ECS"
  cluster_name      = var.cluster_name
  service_name      = var.service_name
  subnets           = var.subnets
  target_group_arn = module.alb.ecs_alb_tg_arn
  vpc_id            = var.vpc_id
}
