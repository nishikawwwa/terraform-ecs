# === ALB ===
variable "name" {
  type    = string
  default = "ecs-alb"
}

variable "subnets" {
  type = list(string)
  default = [
    "subnet-ce4fb286",
    "subnet-b98ca3e2",
    "subnet-1a975031",
  ]
}

variable "vpc_id" {
  type    = string
  default = "vpc-471f2c20"
}

# === ECS ===
variable "cluster_name" {
  type    = string
  default = "ecs-cluster"
}

variable "service_name" {
  type    = string
  default = "ecs-service"
}
