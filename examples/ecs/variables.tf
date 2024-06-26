#cluster
variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
  default = "gha-test-cluster"
}
variable "use_ec2" {
  description = "Boolean to decide if EC2 should be used"
  type        = bool
  default     = true
}
variable "security_groups" {
  description = "List of security group IDs for the ASG"
  type        = list(string)
  default = [ "sg-0175633b9f5769284" ]
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default = "t3.micro"
}

variable "key_name" {
  description = "Key name for SSH access"
  type        = string
  default = "default-key"
}

variable "iam_instance_profile" {
  description = "IAM instance profile for the EC2 instances"
  type        = string
  default = "default-role"
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
  default = [ "sg-0175633b9f5769284" ]
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

# ecs task
variable "family" {
  description = "A unique name for your task definition"
  type        = string
  default = "gha-test-family"
}

variable "container_definitions" {
  description = "A list of valid container definitions"
  type        = string
  default     = <<EOF
[
  {
    "name": "my-container",
    "image": "nginx",
    "cpu": 256,
    "memory": 512,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ],
    "essential": true
  }
]
EOF
}

variable "network_mode" {
  description = "The Docker networking mode to use for the containers in the task"
  type        = string
  default     = "bridge"
}

variable "requires_compatibilities" {
  description = "A set of launch types required by the task"
  type        = list(string)
  default     = ["EC2"]
}

variable "cpu" {
  description = "The number of CPU units used by the task"
  type        = string
  default = "256"
}

variable "memory" {
  description = "The amount of memory (in MiB) used by the task"
  type        = string
  default = "512"
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that allows your Amazon ECS container agent to make calls to the required AWS APIs on your behalf"
  type        = string
  default = "arn:aws:iam::339712743018:role/task-def-role-arq"
}

variable "task_role_arn" {
  description = "The ARN of the IAM role that containers in this task can assume"
  type        = string
  default = "arn:aws:iam::339712743018:role/task-def-role-arq"
}
variable "managed_termination_protection" {
  description = "Managed termination protection"
  type        = string
  default     = "DISABLED"
}