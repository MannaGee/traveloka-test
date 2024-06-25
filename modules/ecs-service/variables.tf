variable "service_name" {
  description = "The name of the ECS service"
  type        = string
  default = "gha-test-ecs"
}

variable "use_fargate" {
  description = "Boolean to decide if Fargate should be used"
  type        = bool
  default     = false
}

variable "task_definition" {
  description = "The task definition to use for the service"
  type        = string
  default = "sample-task-def"
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}
variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
  default = 1
}

variable "launch_type" {
  description = "The launch type on which to run your service"
  type        = string
  default     = "EC2"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
  default = [ "subnet-0c2386fb13d35787a", "subnet-0c6fc3e013c492bca" ]
}

variable "security_group_ids" {
  description = "List of security group IDs for the ECS service"
  type        = list(string)
  default = [ "	sg-067a85f23eb1ac35e" ]
}

variable "assign_public_ip" {
  description = "Assign a public IP to the ECS service"
  type        = bool
  default     = false
}

variable "target_group_arn" {
  description = "The ARN of the load balancer target group"
  type        = string
  default = ""
}

variable "container_name" {
  description = "The name of the container to associate with the load balancer"
  type        = string
  default = "gha-test-container"
}

variable "container_port" {
  description = "The port on the container to associate with the load balancer"
  type        = number
  default = 80
}

variable "deployment_maximum_percent" {
  description = "Upper limit on the number of running tasks during a deployment"
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "Lower limit on the number of running tasks during a deployment"
  type        = number
  default     = 50
}