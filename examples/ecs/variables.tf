#cluster
variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}
variable "use_ec2" {
  description = "Boolean to decide if EC2 should be used"
  type        = bool
  default     = true
}
variable "security_groups" {
  description = "List of security group IDs for the ASG"
  type        = list(string)
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile for the EC2 instances"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Associate public IP address with instances"
  type        = bool
  default     = true
}
variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
  default     = 1
}
variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
  default     = 3
}
variable "desired_capacity" {
  description = "Desired capacity of the ASG"
  type        = number
  default     = 1
}
variable "health_check_grace_period" {
  description = "Health check grace period for the ASG"
  type        = number
  default     = 300
}

#service
variable "service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster"
  type        = string
}

variable "use_fargate" {
  description = "Boolean to decide if Fargate should be used"
  type        = bool
  default     = false
}

variable "task_definition" {
  description = "The task definition to use for the service"
  type        = string
}

variable "desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
}

variable "launch_type" {
  description = "The launch type on which to run your service"
  type        = string
  default     = "EC2"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the ECS service"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Assign a public IP to the ECS service"
  type        = bool
  default     = false
}

variable "target_group_arn" {
  description = "The ARN of the load balancer target group"
  type        = string
}

variable "container_name" {
  description = "The name of the container to associate with the load balancer"
  type        = string
}

variable "container_port" {
  description = "The port on the container to associate with the load balancer"
  type        = number
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

# ecs task
variable "family" {
  description = "A unique name for your task definition"
  type        = string
}

variable "container_definitions" {
  description = "A list of valid container definitions"
  type        = string
}

variable "network_mode" {
  description = "The Docker networking mode to use for the containers in the task"
  type        = string
  default     = "bridge"
}

variable "requires_compatibilities" {
  description = "A set of launch types required by the task"
  type        = list(string)
}

variable "cpu" {
  description = "The number of CPU units used by the task"
  type        = string
}

variable "memory" {
  description = "The amount of memory (in MiB) used by the task"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that allows your Amazon ECS container agent to make calls to the required AWS APIs on your behalf"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the IAM role that containers in this task can assume"
  type        = string
}