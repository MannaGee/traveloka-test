module "ecs_cluster" {
  source                 = "../../modules/ecs-cluster"
  cluster_name           = var.cluster_name
  use_ec2                = var.use_ec2
  ec2_ami_id             = var.ec2_ami_id 
  instance_type          = var.instance_type
  iam_instance_profile   = var.iam_instance_profile
  security_groups        = var.security_groups
  key_name               = var.key_name
  subnet_ids             = var.subnet_ids 
  desired_capacity       = var.desired_capacity
  max_size               = var.max_size
  min_size               = var.min_size
  associate_public_ip_address = var.associate_public_ip_address
  health_check_grace_period   = var.health_check_grace_period
}

module "ecs_service" {
  source             = "../../modules/ecs-service"
  service_name       = var.service_name
  container_name     = var.container_name
  use_fargate        = var.use_fargate
  cluster_id         = var.cluster_id
  container_port     = var.container_port
  security_group_ids = var.security_group_ids
  task_definition    = var.task_definition
  subnet_ids         = var.subnet_ids
  desired_count      = var.desired_count
  target_group_arn   = var.target_group_arn   
}

module "ecs_task" {
  source                   = "../../modules/ecs-taskdef"
  family                   = var.family
  use_fargate              = var.use_fargate  
  task_role_arn            = var.task_role_arn
  container_definitions    = var.container_definitions
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn
  requires_compatibilities = var.requires_compatibilities
}
